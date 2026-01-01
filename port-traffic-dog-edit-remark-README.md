# 端口流量狗 - 修改备注功能补丁

## 📋 功能说明

在 `manage_traffic_limits()` (端口限制设置管理) 菜单中添加第4个选项 **"修改端口备注"**,允许用户快速修改已监控端口的备注信息。

## 🎯 修改内容

### 1. 新增功能函数

**函数名:** `edit_port_remark()`

**功能特性:**
- ✅ 列出所有监控端口及当前备注
- ✅ 选择端口后显示当前备注
- ✅ 支持修改备注内容
- ✅ 支持清空备注(直接回车)
- ✅ 实时更新配置文件
- ✅ 彩色输出,用户体验友好

### 2. 更新菜单选项

**原菜单:**
```
1. 设置端口带宽限制（速率控制）
2. 设置端口流量配额（总量控制）
3. 修改端口统计方式（双向/单向）
0. 返回主菜单
```

**新菜单:**
```
1. 设置端口带宽限制（速率控制）
2. 设置端口流量配额（总量控制）
3. 修改端口统计方式（双向/单向）
4. 修改端口备注                    ← 新增
0. 返回主菜单
```

## 🔧 集成方式

### 方案 A: 手动修改 (推荐)

1. 打开远程服务器上的脚本文件:
   ```bash
   vim /usr/local/bin/port-traffic-dog.sh
   ```

2. 找到 `manage_traffic_limits()` 函数定义位置 (大约 1551 行)

3. 在 `manage_traffic_limits()` 函数**之前**插入 `edit_port_remark()` 函数
   - 复制 `port-traffic-dog-edit-remark-patch.sh` 中的 `edit_port_remark()` 函数

4. 替换 `manage_traffic_limits()` 函数内容
   - 将菜单选项从 `[0-3]` 改为 `[0-4]`
   - 在 case 语句中添加 `4) edit_port_remark ;;`

5. 保存并退出

### 方案 B: 自动化脚本

在 VPS 上执行以下命令:

```bash
# 下载补丁文件
curl -sL "https://raw.githubusercontent.com/zywe03/realm-xwPF/main/port-traffic-dog-edit-remark-patch.sh" -o /tmp/patch.sh

# 备份原始文件
cp /usr/local/bin/port-traffic-dog.sh /usr/local/bin/port-traffic-dog.sh.backup

# 手动集成(参考 patch.sh 内容)
vim /usr/local/bin/port-traffic-dog.sh
```

## 📸 使用示例

### 操作流程:

```
终端输入: dog
  ↓
选择: 2 (端口限制设置管理)
  ↓
选择: 4 (修改端口备注)
  ↓
显示端口列表:
  1. 端口 8080 - 当前备注: 香港节点
  2. 端口 8443 - 当前备注: 无
  0. 返回上级菜单
  ↓
选择端口编号: 2
  ↓
端口 8443 当前备注: 无
请输入新的备注内容 (直接回车清空备注):
备注: 美国节点-洛杉矶
  ↓
✓ 端口 8443 备注已更新为: 美国节点-洛杉矶
```

## 💾 配置文件结构

修改备注后,配置文件 `/etc/port-traffic-dog/config.json` 中的对应字段会更新:

```json
{
  "ports": {
    "8443": {
      "name": "端口8443",
      "enabled": true,
      "billing_mode": "double",
      "remark": "美国节点-洛杉矶",
      "created_at": "2026-01-01T10:30:00+08:00"
    }
  }
}
```

## 🎨 代码设计原则

遵循以下原则:
- ✅ **KISS** - 简洁直观的单一功能
- ✅ **DRY** - 复用现有的配置读写函数
- ✅ **一致性** - 与现有菜单风格保持一致
- ✅ **健壮性** - 输入验证和错误处理

## 📝 注意事项

1. **依赖工具:** 需要 `jq` 命令 (脚本已自动安装)
2. **权限要求:** 需要 root 权限修改配置文件
3. **配置保存:** 备注信息实时保存到配置文件
4. **导出兼容:** 备注信息会随配置导出/导入功能一起保留

## 🔍 测试建议

修改完成后测试:
1. 进入 "修改端口备注" 菜单
2. 选择一个端口修改备注
3. 返回主菜单查看端口列表,确认备注已显示
4. 重新进入修改备注菜单,确认新备注已保存

## 📞 技术支持

如有问题,请查看:
- 项目主页: https://zywe.de
- GitHub: https://github.com/zywe03/realm-xwPF
