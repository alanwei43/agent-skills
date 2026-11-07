# Agent Skills

可通过 [skills CLI](https://github.com/vercel-labs/skills) 安装的 Agent 技能集合。

## 英语学习助手

[`english-learning-assistant`](skills/english-learning-assistant/SKILL.md) 默认使用中文，根据输入类型讲解：

- **单词与短语**：含义、词性、适用的词形变化、同义词和反义词、常见搭配、高频用法及易错点。
- **句子**：中文译文、五种基本句型判断、句子成分拆解、重点短语与语法注意事项；支持复合句、疑问句、祈使句和纠错。

### 安装

使用 Node.js 22.20 或更高版本。官方 CLI 名称为 `skills`，安装命令中的包名带 **s**。

文件推送到 GitHub 仓库后，从目标项目目录安装：

```bash
npx skills add alanwei43/agent-skills --skill english-learning-assistant
```

按提示选择目标 Agent；也可指定 Codex：

```bash
npx skills add alanwei43/agent-skills --skill english-learning-assistant -a codex
```

需要跨项目使用时加 `-g`。本地开发时，在本仓库目录下查看可发现的技能，或从本地安装：

```bash
npx skills add . --list
npx skills add . --skill english-learning-assistant
```

### 使用示例

安装后，请让支持技能的 Agent 使用 `english-learning-assistant` 讲解，例如：

```text
请用英语学习助手讲解 happy。
请讲解 take off 的含义、词形变化和易错点。
请讲解 look forward to，并说明后面为什么用 doing。
请拆解 She gave me a book yesterday. 的成分和基本句型。
请分析 The book that you lent me is interesting. 的主句和从句。
请解释 She suggested me to go. 的问题并修改。
```

### 目录结构与发现

```text
skills/
└── english-learning-assistant/
    ├── SKILL.md
    └── agents/
        └── openai.yaml
```

`SKILL.md` 包含 `name`、`description` YAML 元数据及完整技能指令；目录名与技能名一致。`agents/openai.yaml` 提供可选的界面展示信息。技能无需额外脚本、API 密钥或 MCP 服务。

`skills/<name>/SKILL.md` 属于 CLI 默认搜索路径，无需额外注册文件或 npm 包。见 [CLI 技能发现规则](https://github.com/vercel-labs/skills/blob/main/docs/creating-skills.md) 和 [Agent Skills 规范](https://agentskills.io/specification)。

本地创建文件不会立即使其出现在 skills.sh 搜索中。仓库需公开且文件已推送，其他用户才能直接安装；根据 [skills.sh FAQ](https://skills.sh/docs/faq)，用户通过 `npx skills add` 安装时的匿名遥测会触发榜单收录，是否已可检索及索引更新时间以平台为准。
