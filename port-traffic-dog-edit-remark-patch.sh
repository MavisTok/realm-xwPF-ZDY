#!/bin/bash
# port-traffic-dog.sh 修改备注功能补丁
# 在 manage_traffic_limits() 函数前添加此函数

# 修改端口备注
edit_port_remark() {
    echo -e "${BLUE}=== 修改端口备注 ===${NC}"

    local active_ports=$(jq -r '.ports | keys[]' "$CONFIG_FILE" 2>/dev/null | sort -n)
    if [ -z "$active_ports" ]; then
        echo -e "${RED}没有正在监控的端口${NC}"
        sleep 2
        manage_traffic_limits
        return
    fi

    echo -e "${YELLOW}当前监控的端口列表：${NC}"
    local port_list=()
    local idx=1
    for port in $active_ports; do
        local current_remark=$(jq -r ".ports.\"$port\".remark // \"\"" "$CONFIG_FILE")
        local remark_display="${current_remark:-无}"
        echo -e "  $idx. 端口 $port - 当前备注: ${GREEN}${remark_display}${NC}"
        port_list+=("$port")
        ((idx++))
    done
    echo "  0. 返回上级菜单"
    echo

    read -p "请选择要修改备注的端口 [0-$((idx-1))]: " port_choice

    if [ "$port_choice" = "0" ]; then
        manage_traffic_limits
        return
    fi

    if ! [[ "$port_choice" =~ ^[0-9]+$ ]] || [ "$port_choice" -lt 1 ] || [ "$port_choice" -gt ${#port_list[@]} ]; then
        echo -e "${RED}无效选择${NC}"
        sleep 1
        edit_port_remark
        return
    fi

    local target_port="${port_list[$((port_choice-1))]}"
    local current_remark=$(jq -r ".ports.\"$target_port\".remark // \"\"" "$CONFIG_FILE")

    echo
    echo -e "端口 ${GREEN}$target_port${NC} 当前备注: ${BLUE}${current_remark:-无}${NC}"
    echo
    echo "请输入新的备注内容 (直接回车清空备注):"
    read -p "备注: " new_remark

    echo
    echo -e "${YELLOW}正在更新备注...${NC}"

    # 更新配置文件中的备注
    local tmp_file=$(mktemp)
    jq ".ports.\"$target_port\".remark = \"$new_remark\"" "$CONFIG_FILE" > "$tmp_file"
    mv "$tmp_file" "$CONFIG_FILE"

    if [ -n "$new_remark" ]; then
        echo -e "${GREEN}✓ 端口 $target_port 备注已更新为: $new_remark${NC}"
    else
        echo -e "${GREEN}✓ 端口 $target_port 备注已清空${NC}"
    fi

    sleep 2
    edit_port_remark
}

# 修改后的 manage_traffic_limits() 函数
manage_traffic_limits() {
    echo -e "${BLUE}=== 端口限制设置管理 ===${NC}"
    echo "1. 设置端口带宽限制（速率控制）"
    echo "2. 设置端口流量配额（总量控制）"
    echo "3. 修改端口统计方式（双向/单向）"
    echo "4. 修改端口备注"
    echo "0. 返回主菜单"
    echo
    read -p "请选择操作 [0-4]: " choice

    case $choice in
        1) set_port_bandwidth_limit ;;
        2) set_port_quota_limit ;;
        3) change_port_billing_mode ;;
        4) edit_port_remark ;;
        0) show_main_menu ;;
        *) echo -e "${RED}无效选择${NC}"; sleep 1; manage_traffic_limits ;;
    esac
}
