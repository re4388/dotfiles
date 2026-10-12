---
name: create-Codex-md
description: Creates a AGENTS.md file for the current project folder by scanning the codebase and interviewing the user. Use this skill whenever the user asks to "create a AGENTS.md", "generate a AGENTS.md", "set up AGENTS.md", "initialize Codex context", or "help Codex understand this project". Also trigger when the user says things like "Codex doesn't know my project" or "set up context for this repo". Always use this skill — do not attempt to write AGENTS.md from scratch without following this process.
---

# Create AGENTS.md

Generate a high-quality `AGENTS.md` for the current working directory by combining automated codebase scanning with targeted user questions.

## What is AGENTS.md?

`AGENTS.md` is a special file that Codex automatically reads at the start of every session. It gives Codex persistent context about the project — so Codex always knows the tech stack, conventions, and common commands without being told every time.

## Process Overview

1. **Scan** — read key files to infer as much as possible automatically
2. **Interview** — ask targeted questions only for what can't be inferred
3. **Generate** — write the AGENTS.md
4. **Confirm** — show a preview and let the user approve or tweak

---

## Step 1: Scan the Codebase

Run the following bash commands to collect raw signals. Do them all at once.

```bash
# Project structure (top 2 levels)
find . -maxdepth 2 \
  -not -path './.git/*' \
  -not -path './node_modules/*' \
  -not -path './target/*' \
  -not -path './.gradle/*' \
  -not -path './build/*' \
  -not -path './dist/*' \
  -not -path './__pycache__/*' \
  | sort

# Detect project type via config files
ls -1 pom.xml build.gradle build.gradle.kts \
       package.json pyproject.toml setup.py \
       Cargo.toml go.mod Makefile \
       docker-compose.yml docker-compose.yaml \
       Dockerfile 2>/dev/null

# Existing README / docs
cat README.md 2>/dev/null | head -80
cat README.mdx 2>/dev/null | head -80

# Check for existing AGENTS.md
cat AGENTS.md 2>/dev/null
```

Then read the **primary config file** based on what was detected:

| Detected file | Read it for |
|---|---|
| `pom.xml` | groupId, artifactId, Java version, dependencies |
| `package.json` | name, scripts, dependencies, devDependencies |
| `build.gradle` / `build.gradle.kts` | plugins, dependencies |
| `pyproject.toml` / `setup.py` | name, dependencies, python version |
| `go.mod` | module name, Go version |
| `Cargo.toml` | package name, dependencies |

Also read if present:
- `src/main/resources/application.yml` or `application.properties` — Spring Boot config
- `.env.example` — environment variables
- `docker-compose.yml` — services, ports, databases
- Any file named `*Architecture*`, `*ARCHITECTURE*`, `*DESIGN*`, `*design*`

---

## Step 2: Interview the User

After scanning, you will have inferred some things and be missing others. Ask **only** the questions you cannot answer from the scan. Group them into a single message — never ask one question at a time.

### Questions to ask if not inferrable:

**Project overview**
- What does this project do? (one or two sentences)
- Is this a monolith, microservice, or monorepo?

**Architecture** (ask if structure is non-obvious)
- Are there any architectural rules to know? (e.g. "controllers never call repositories directly", "all DB access via service layer")
- Any key design patterns in use? (e.g. CQRS, event-driven, hexagonal)

**Development conventions** (always ask — rarely in config files)
- Any naming conventions? (e.g. class naming, file naming, branch naming)
- Any code style rules beyond the formatter? (e.g. "no lombok", "prefer records over classes", "always use Optional")
- What's the test strategy? (unit only? integration? e2e? coverage target?)

**Commands** (ask if not found in README or package.json scripts)
- How do you build, run, and test locally?
- Any environment setup steps needed before running? (e.g. `docker-compose up`, `cp .env.example .env`)

**What to avoid**
- Anything Codex should NOT do in this codebase? (e.g. "don't modify generated files", "don't add new dependencies without asking", "never change the DB schema directly")

Skip any question where you already have a confident answer from scanning.

---

## Step 3: Generate AGENTS.md

Use this template. Fill in every section — remove a section only if genuinely not applicable (e.g. no database in project).

```markdown
# AGENTS.md

## Project Overview
<!-- What the project does, who uses it, key context -->

**Tech Stack:**
- Language: 
- Framework: 
- Database: 
- Other key tools: 

**Architecture:** <!-- monolith / microservice / monorepo, key patterns -->

## Folder Structure
<!-- Only list non-obvious folders and what they contain -->
\`\`\`
src/
├── main/
│   ├── java/com/example/
│   │   ├── controller/   # HTTP layer, no business logic here
│   │   ├── service/      # Business logic
│   │   ├── repository/   # DB access via Spring Data
│   │   └── domain/       # Entities, DTOs, value objects
│   └── resources/
│       └── application.yml
└── test/
\`\`\`

## Common Commands
\`\`\`bash
# Build
<command>

# Run locally
<command>

# Run tests
<command>

# Other useful commands
<command>
\`\`\`

## Development Conventions

**Naming:**
- <!-- e.g. Classes: PascalCase, methods: camelCase, DB collections: snake_case -->

**Code Style:**
- <!-- e.g. No Lombok, prefer records, always use Optional for nullable returns -->

**Architecture Rules:**
- <!-- e.g. Controllers → Services → Repositories only, no skipping layers -->
- <!-- e.g. DTOs never passed below service layer -->

**Testing:**
- <!-- e.g. Unit tests for all service methods, integration tests for repositories -->
- <!-- e.g. Test coverage target: 80% -->

## Environment Setup
\`\`\`bash
# First-time setup
<steps>
\`\`\`

**Required environment variables:** (see `.env.example`)
- `VAR_NAME` — description

## What NOT to Do
- <!-- e.g. Don't modify files under src/generated/ — they are auto-generated -->
- <!-- e.g. Don't add Maven dependencies without discussing first -->
- <!-- e.g. Never alter migration files after they've been committed -->
```

### Writing guidelines:
- Be **specific and concrete** — "use camelCase for methods" not "follow Java conventions"
- Keep each bullet to **one actionable sentence**
- Omit sections that don't apply — a lean AGENTS.md is better than a padded one
- If something has a strong default (e.g. standard Maven layout), just write "standard Maven structure" rather than listing every folder

---

## Step 4: Preview and Confirm

Show the full generated AGENTS.md in a code block and ask:

> "這是草稿，你有想要調整的嗎？確認後我就寫入 `AGENTS.md`。"

After confirmation, write the file:

```bash
cat > AGENTS.md << 'EOF'
<generated content>
EOF
```

If `AGENTS.md` already existed (detected in Step 1), show a diff of what changed and ask for confirmation before overwriting.

---

## Tips

- If the project has multiple sub-modules (monorepo), create a root `AGENTS.md` summarising the whole repo, and offer to create per-module `AGENTS.md` files as well.
- If you find an existing `AGENTS.md`, read it first. Update it rather than replacing it wholesale — preserve any manual additions the user may have made.
- The "What NOT to Do" section is often the most valuable — probe for this specifically if the user doesn't mention it.