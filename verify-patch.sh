#!/bin/bash
# 验证补丁文件完整性脚本

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PATCH_FILE="${1:-/tmp/patch.sh}"

echo -e "${BLUE}=== 端口流量狗补丁文件验证工具 ===${NC}"
echo ""

# 检查文件是否存在
if [ ! -f "$PATCH_FILE" ]; then
    echo -e "${RED}✗ 补丁文件不存在: $PATCH_FILE${NC}"
    echo ""
    echo "请先下载补丁文件:"
    echo "  curl -sL \"https://raw.githubusercontent.com/MavisTok/realm-xwPF-ZDY/main/port-traffic-dog-edit-remark-patch.sh\" -o /tmp/patch.sh"
    exit 1
fi

echo -e "${GREEN}✓ 补丁文件存在: $PATCH_FILE${NC}"
echo ""

# 验证关键函数和内容
echo -e "${YELLOW}检查补丁内容...${NC}"
echo ""

# 检查 edit_port_remark 函数
if grep -q "^edit_port_remark()" "$PATCH_FILE"; then
    echo -e "${GREEN}✓ edit_port_remark() 函数存在${NC}"
else
    echo -e "${RED}✗ edit_port_remark() 函数缺失${NC}"
    exit 1
fi

# 检查 manage_traffic_limits 函数
if grep -q "^manage_traffic_limits()" "$PATCH_FILE"; then
    echo -e "${GREEN}✓ manage_traffic_limits() 函数存在${NC}"
else
    echo -e "${RED}✗ manage_traffic_limits() 函数缺失${NC}"
    exit 1
fi

# 检查菜单选项 4
if grep -q "echo \"4. 修改端口备注\"" "$PATCH_FILE"; then
    echo -e "${GREEN}✓ 菜单选项 \"4. 修改端口备注\" 存在${NC}"
else
    echo -e "${RED}✗ 菜单选项 \"4. 修改端口备注\" 缺失${NC}"
    exit 1
fi

# 检查输入提示 [0-4]
if grep -q "\[0-4\]" "$PATCH_FILE"; then
    echo -e "${GREEN}✓ 输入提示 [0-4] 存在${NC}"
else
    echo -e "${RED}✗ 输入提示 [0-4] 缺失${NC}"
    exit 1
fi

# 检查 case 分支 4
if grep -q "4) edit_port_remark ;;" "$PATCH_FILE"; then
    echo -e "${GREEN}✓ case 分支 \"4) edit_port_remark ;;\" 存在${NC}"
else
    echo -e "${RED}✗ case 分支 \"4) edit_port_remark ;;\" 缺失${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}=== 详细内容预览 ===${NC}"
echo ""

echo -e "${YELLOW}1. edit_port_remark() 函数位置:${NC}"
grep -n "^edit_port_remark()" "$PATCH_FILE"
echo ""

echo -e "${YELLOW}2. manage_traffic_limits() 菜单选项:${NC}"
sed -n '/^manage_traffic_limits()/,/^}/p' "$PATCH_FILE" | grep -n "echo"
echo ""

echo -e "${YELLOW}3. case 分支:${NC}"
sed -n '/^manage_traffic_limits()/,/^}/p' "$PATCH_FILE" | grep -n "edit_port_remark"
echo ""

echo -e "${GREEN}=== 验证通过! ===${NC}"
echo ""
echo "补丁文件完整且正确,包含:"
echo "  • edit_port_remark() 函数"
echo "  • 更新后的 manage_traffic_limits() 函数"
echo "  • 菜单选项 \"4. 修改端口备注\""
echo "  • 输入提示 [0-4]"
echo "  • case 分支 4) edit_port_remark ;;"
echo ""
echo "可以安全地集成到 /usr/local/bin/port-traffic-dog.sh"
echo ""
echo "下一步:"
echo "  1. 备份原始脚本: cp /usr/local/bin/port-traffic-dog.sh /usr/local/bin/port-traffic-dog.sh.backup"
echo "  2. 编辑脚本: vim /usr/local/bin/port-traffic-dog.sh"
echo "  3. 参考集成指南: INTEGRATION_GUIDE.md"
