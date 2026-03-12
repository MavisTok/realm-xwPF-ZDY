# Realm 全功能一键网络转发管理,纯脚本快速搭建中转服务器

[中文](README.md) | [English](README_EN.md) | [端口流量狗脚本介绍](port-traffic-dog-README.md)

---

> 🚀 **网络转发管理脚本** - 同步官方 Realm 最新版全部功能，网络链路测试，端口流量犬，保持极简本质,可视化规则操作提高效率，纯脚本构建网络转发服务

## 脚本界面预览

<details>
<summary>点击查看界面截图</summary>

### xwPF.sh realm转发脚本

![81ce7ea9e40068f6fda04b66ca3bd1ff.gif](https://i.mji.rip/2025/12/12/81ce7ea9e40068f6fda04b66ca3bd1ff.gif)

### 端口流量犬

![cc59017896d277a8b35109ae44eac977.gif](https://i.mji.rip/2025/12/12/cc59017896d277a8b35109ae44eac977.gif)

### 中转网络链路测试脚本
```
===================== 网络链路测试功能完整报告 =====================

✍️ 参数测试报告
─────────────────────────────────────────────────────────────────
  本机（客户端）发起测试
  目标: 92.112.*.*:5201
  测试方向: 客户端 ↔ 服务端 
  单项测试时长: 30秒
  系统：Debian GNU/Linux 12 | 内核: 6.1.0-35-cloud-amd64
  本机：cubic+htb（拥塞控制算法+队列）
  TCP接收缓冲区（rmem）：4096   131072  6291456
  TCP发送缓冲区（wmem）：4096   16384   4194304

🧭 TCP大包路由路径分析（基于nexttrace）
─────────────────────────────────────────────────────────────────
 AS路径: AS979 > AS209699
 运营商: Private Customer - SBC Internet Services
 地理路径: 日本 > 新加坡
 地图链接: https://assets.nxtrace.org/tracemap/b4a9ec9f-8b69-5793-a9b6-0cd0981d8de0.html
─────────────────────────────────────────────────────────────────
🌐 BGP对等体关系分析 (基于bgp.tools)
─────────────────────────────────────────────────────────────────
上游节点(Upstreams) :9 │ 对等节点(Peers):44

AS979       │AS21859     │AS174       │AS2914      │AS3257      │AS3356      │AS3491      
NetLab      │Zenlayer    │Cogent      │NTT         │GTT         │Lumen       │PCCW        

AS5511      │AS6453      │AS6461      │AS6762      │AS6830      │AS12956     │AS1299      
Orange      │TATA        │Zayo        │Sparkle     │Liberty     │Telxius     │Arelion     

AS3320      
DTAG        
─────────────────────────────────────────────────────────────────
 图片链接：https://bgp.tools/pathimg/979-55037bdd89ab4a8a010e70f46a2477ba7456640ec6449f518807dd2e
─────────────────────────────────────────────────────────────────
⚡ 网络链路参数分析（基于hping3 & iperf3）
─────────────────────────────────────────────────────────────────────────────────
    PING & 抖动           ⬆️ TCP上行带宽                     ⬇️ TCP下行带宽
─────────────────────  ─────────────────────────────  ─────────────────────────────
  平均: 72.3ms          220 Mbps (27.5 MB/s)             10 Mbps (1.2 MB/s)           
  最低: 69.5ms          总传输量: 786 MB             总传输量: 35.4 MB        
  最高: 75.9ms          重传: 0 次                    重传: 5712 次             
  抖动: 6.4ms       

─────────────────────────────────────────────────────────────────────────────────────────────
 方向       │ 吞吐量                   │ 丢包率                   │ 抖动
─────────────────────────────────────────────────────────────────────────────────────────────
 ⬆️ UDP上行 │ 219.0 Mbps (27.4 MB/s)    │ 2021/579336 (0.35%)       │ 0.050 ms                 
 ⬇️ UDP下行 │ 10.0 Mbps (1.2 MB/s)      │ 0/26335 (0%)              │ 0.040 ms                 

─────────────────────────────────────────────────────────────────
测试完成时间: 2025-08-28 20:12:29 | 脚本开源地址：https://github.com/MavisTok/realm-xwPF-ZDY
```

</details>

## 快速开始

### 一键安装

```bash
wget -qO- https://raw.githubusercontent.com/MavisTok/realm-xwPF-ZDY/main/xwPF.sh | sudo bash -s install
```

### 网络受限使用加速源,一键安装

```bash
wget -qO- https://github.lynntox.workers.dev/https://raw.githubusercontent.com/MavisTok/realm-xwPF-ZDY/main/xwPF.sh | sudo bash -s install
```

```bash
wget -qO- https://v6.gh-proxy.org/https://raw.githubusercontent.com/MavisTok/realm-xwPF-ZDY/main/xwPF.sh | sudo bash -s install
```
若加速源失效，可多次重试或更换其他具有内置加速功能的代理源

## 无法联网的离线安装

<details>
<summary>点击展开离线安装方法</summary>

适用于完全无法连接网络

**1. 在有网络的设备上下载以下文件**

- **主脚本**：[xwPF.sh](https://github.com/MavisTok/realm-xwPF-ZDY/raw/main/xwPF.sh)
- **模块文件**（全部需要）：https://github.com/MavisTok/realm-xwPF-ZDY/tree/main/lib

- **Realm 程序**（根据系统架构选择）：

| 架构 | 适用系统 | 下载链接 | 检测命令 |
|------|----------|----------|----------|
| x86_64 | 常见64位系统 | [realm-x86_64-unknown-linux-gnu.tar.gz](https://github.com/zhboner/realm/releases/latest) | `uname -m` 显示 `x86_64` |
| aarch64 | ARM64系统 | [realm-aarch64-unknown-linux-gnu.tar.gz](https://github.com/zhboner/realm/releases/latest) | `uname -m` 显示 `aarch64` |
| armv7 | ARM32系统（如树莓派） | [realm-armv7-unknown-linux-gnueabihf.tar.gz](https://github.com/zhboner/realm/releases/latest) | `uname -m` 显示 `armv7l` 或 `armv6l` |

**2. 将文件放置到目标服务器**

```
/usr/local/bin/            ← 脚本安装目录（固定路径）
├── xwPF.sh                ← 主脚本
└── lib/                   ← 创建 lib 子目录
    ├── core.sh
    ├── rules.sh
    ├── server.sh
    ├── realm.sh
    └── ui.sh

~/                         ← Realm 压缩包放在任意其他位置
└── realm-xxx.tar.gz
```

**3. 执行离线安装**

```bash
chmod +x /usr/local/bin/xwPF.sh
ln -sf /usr/local/bin/xwPF.sh /usr/local/bin/pf
bash /usr/local/bin/xwPF.sh
```

选择 **1. 安装配置** 后：
1. 提示 **是否更新脚本？(y/N):** → 直接回车跳过（离线无法更新）
2. 提示 **离线安装realm输入完整路径(回车默认自动下载):** → 输入 Realm 压缩包的完整路径即可

</details>


## ✨ 核心特性

- **原生Realm全功能** - 同步支持最新版realm的所有原生功能
  - tcp/udp协议
  - ws/wss/tls 加密解密并转发
  - 单中转多出口
  - 多中转单出口
  - Proxy Protocol
  - MPTCP
  - 指定中转机的某个入口 IP,或指定某个出口 IP (适用于多IP情况和一入口多出口和多入口一出口的情况)
  - 指定中转机的入口网卡,或指定某个出口网卡 (适用于多网卡情况)
  - 更多玩法参考[zhboner/realm](https://github.com/zhboner/realm)
- **多发行版支持** - 适配 Debian/Ubuntu、Alpine、CentOS/RHEL 系列，自动识别包管理器与 init 系统（systemd / OpenRC）
- **快速体验** - 一键安装快速轻量上手体验网络转发
- **智能检测** - 自动检测系统架构、端口冲突,连接可用性

- **搭建隧道** - 双端realm架构支持 TLS,ws,wss,搭建隧道
- **端口段配置** - 支持单端口(`8080`)、逗号多端口(`8080,8081`)、端口段(`8080-8090`)及混合写法(`8080-8082,9000`)，批量创建转发规则
- **负载均衡** - 支持轮询、IP哈希等策略，可配置权重分配
- **故障转移** - 使用系统工具,完成自动故障检测,保持轻量化
- **规则备注** - 清晰的备注功能,不再需要额外记忆

- **端口流量犬** - 统计端口流量，控制端口限速，限流，可设置通知方式
- **直观配置系统MPTCP** - 清晰的展示MPTCP界面
- **网络链路脚本** - 测试链路延迟、带宽、稳定性,大包路由情况（基于hping3 & iperf3 & nexttrace & bgp.tools）

- **一键导出** - 打包全部文件为压缩包自由迁移(包括备注等等信息完全迁移)
- **一键导入** - 识别导出的压缩包完成自由迁移
- **一键识别批量导入** 自写realm的规则配置,方便管理和维护自己的规则集
- **完整卸载** - 分阶段全面清理，“轻轻的我走了，正如我轻轻的来”

### 依赖工具
原则均优先**Linux 原生轻量化工具**，保持系统干净轻量化

| 工具       | 用途           | 工具        | 用途             |
|------------|----------------|-------------|------------------|
| `curl`     | 下载和IP获取   | `wget`      | 备用下载工具     |
| `tar`      | 解压缩工具     | `unzip`     | ZIP解压缩        |
| `bc`       | 数值计算       | `nc`        | 网络连接测试     |
| `bash /dev/tcp` | 网络连接测试（内置） | `inotify`   | 标记文件         |
| `grep`/`cut` | 文本处理识别 | `jq`        | JSON数据处理     |
| `iproute2` | MPTCP端点管理  | `nftables`  | 端口流量统计     |
| `tc`       | 流量控制限制   |             |                  |

## 文件结构

> 脚本按需索取，其他功能点击对应菜单才会下载

### 使用realm转发核心安装（安装即有）

```
系统文件
├── /usr/local/bin/
│   ├── realm                    # Realm 主程序
│   ├── xwPF.sh                  # 管理脚本入口
│   ├── lib/                     # 模块目录
│   │   ├── core.sh              # 核心工具（系统检测/依赖/网络/验证）
│   │   ├── rules.sh             # 规则管理（规则CRUD/负载均衡/权重）
│   │   ├── server.sh            # 服务器配置（中转/出口交互/MPTCP管理）
│   │   ├── realm.sh             # Realm 安装/配置生成/服务管理
│   │   └── ui.sh                # 交互菜单/状态显示/卸载
│   └── pf                       # 快捷启动命令
│
├── /etc/realm/                  # Realm 配置目录
│   ├── manager.conf             # 状态管理文件
│   ├── config.json              # Realm 工作配置文件
│   └── rules/                   # 转发规则目录
│       ├── rule-1.conf          # 规则1配置
│       └── ...
│
└── /etc/systemd/system/
    └── realm.service            # Realm 主服务文件
```

### 按需下载（点击对应功能时才会下载）

```
故障转移（开启故障转移时下载）
├── /usr/local/bin/xwFailover.sh         # 故障转移管理脚本
├── /etc/realm/health/
│   └── health_status.conf               # 健康状态文件
└── /etc/systemd/system/
    ├── realm-health-check.service       # 健康检查服务
    └── realm-health-check.timer         # 健康检查定时器

端口流量犬（选择端口流量犬时下载）
├── /usr/local/bin/port-traffic-dog.sh   # 端口流量犬脚本
├── /usr/local/bin/dog                   # 快捷启动命令
└── /etc/port-traffic-dog/
    ├── config.json                      # 流量监控配置文件
    ├── traffic_data.json                # 流量数据备份
    ├── notifications/                   # 通知模块目录
    │   └── telegram.sh                  # Telegram通知模块
    └── logs/                            # 日志目录

中转网络链路测试（选择链路测试时下载）
└── /usr/local/bin/speedtest.sh          # 网络链路测试脚本

配置识别导入（选择识别导入时下载）
└── /etc/realm/xw_realm_OCR.sh           # Realm配置识别脚本

MPTCP（启用MPTCP时创建）
└── /etc/sysctl.d/90-enable-MPTCP.conf   # MPTCP系统配置
```