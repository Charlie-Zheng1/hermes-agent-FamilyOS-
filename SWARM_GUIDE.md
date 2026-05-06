# Hermes Swarm Management Guide

How to run multiple Hermes agents in a managed, non-conflicting way.

## Method 1: `delegate_task` (RECOMMENDED for Swarms)

The **built-in way** to spawn multiple agents. Each worker is fully isolated.

### From within Hermes (I can do this for you):
```python
delegate_task(
    tasks=[
        {"goal": "Research topic X", "toolsets": ["web", "terminal"]},
        {"goal": "Write tests for Y", "toolsets": ["terminal", "file"]},
        {"goal": "Update documentation", "toolsets": ["file"]}
    ]
)
```

### Benefits:
- ✅ Each worker = isolated terminal session
- ✅ Isolated working directory  
- ✅ No config conflicts (they don't use ~/.hermes/)
- ✅ Results auto-aggregated
- ✅ Automatic cleanup
- ✅ Can run in PARALLEL

### Limits:
- Max concurrent children: `delegation.max_concurrent_children` (default 3)
- Max spawn depth: `delegation.max_spawn_depth` (default 2)

---

## Method 2: Kanban Board (Complex Workflows)

Use the **Kanban system** for complex workflows with dependencies, human-in-the-loop, and crash recovery.

### Enable in config.yaml:
```yaml
kanban:
  dispatch_in_gateway: true
  dispatch_interval_seconds: 60
```

### Create tasks:
```bash
# Via Hermes CLI
hermes kanban create --title "Research X" --assignee researcher
hermes kanban create --title "Analyze Y" --assignee analyst --parents <task_id>

# Or via Hermes chat (I can do this):
# "Create a kanban task for researching X, assign to researcher"
```

### Check status:
```bash
hermes kanban list
hermes kanban tail <task_id>
```

### Worker profiles (convention):
| Profile | Does | Workspace |
|---------|------|-----------|
| `researcher` | Reads sources, gathers facts | `scratch` |
| `analyst` | Synthesizes, ranks, de-dupes | `scratch` |
| `writer` | Drafts prose | `scratch` or vault |
| `reviewer` | Reviews output, gates approval | `scratch` |
| `backend-eng` | Server-side code | `worktree` |
| `frontend-eng` | Client-side code | `worktree` |
| `ops` | Scripts, deployments | `ops scripts/` |

---

## Method 3: Manual Multi-Terminals (Advanced)

If you want to run MULTIPLE Hermes instances manually in different terminals:

### Use Different Config Dirs:
```bash
# Terminal 1 - Main agent
export HERMES_CONFIG_DIR="$HOME/.hermes-main"
hermes

# Terminal 2 - Worker 1
export HERMES_CONFIG_DIR="$HOME/.hermes-worker1"
mkdir -p "$HERMES_CONFIG_DIR"
cp -r ~/.hermes/* "$HERMES_CONFIG_DIR/"
hermes

# Terminal 3 - Worker 2
export HERMES_CONFIG_DIR="$HOME/.hermes-worker2"
mkdir -p "$HERMES_CONFIG_DIR"
cp -r ~/.hermes/* "$HERMES_CONFIG_DIR/"
hermes
```

### Or use Docker (Maximum Isolation):
```bash
# Each agent in its own container
docker run -it --name hermes-worker1 \
  -v ~/.hermes:/root/.hermes \
  hermes-agent:latest

docker run -it --name hermes-worker2 \
  -v ~/.hermes:/root/.hermes \
  hermes-agent:latest
```

---

## Tracking & Managing the Swarm

### 1. Session Search (Find Past Work)
```bash
# Search across all past sessions
hermes session search "research on X"

# I can do this too:
# session_search(query="research on X")
```

### 2. Cron Jobs (Scheduled Tasks)
```bash
# List all cron jobs
hermes cron list

# Create a recurring task
hermes cron create --name "nightly-sync" \
  --schedule "0 2 * * *" \
  --prompt "Sync wiki and backup config"
```

### 3. Kanban Dashboard
```bash
# View all tasks
hermes kanban list

# Follow a task
hermes kanban tail <task_id>

# Web dashboard (if enabled)
hermes serve  # Starts web UI at http://localhost:8000
```

### 4. Process List (Background Jobs)
```bash
# List background processes
hermes process list

# Or via terminal
ps aux | grep hermes
```

---

## Added Skills for Swarm Management

These skills have been added to `config/skills/`:

### 1. **litprog-skill** (from tlehman)
- Literate programming for agent harnesses
- URL: https://github.com/tlehman/litprog-skill
- Use case: Writing code with interleaved documentation

### 2. **wondelai/skills** (from wondelai)
- Agent skills for Claude Code and other skills.io-compatible agents
- URL: https://github.com/wondelai/skills
- Use case: Additional skill library for enhanced capabilities

To use these skills, they'll be automatically loaded when needed, or you can activate them manually.

---

## Quick Reference

### Spawn 3 workers (delegation):
```python
delegate_task(
    tasks=[
        {"goal": "Task 1", "toolsets": ["terminal"]},
        {"goal": "Task 2", "toolsets": ["web"]},
        {"goal": "Task 3", "toolsets": ["file"]}
    ]
)
```

### Create kanban workflow:
```bash
hermes kanban create --title "Research phase 1" --assignee researcher
hermes kanban create --title "Analysis" --assignee analyst --parents <id1>
hermes kanban create --title "Write report" --assignee writer --parents <id2>
```

### Check swarm status:
```bash
hermes kanban list          # Kanban tasks
hermes cron list            # Scheduled jobs
hermes session search ""    # Recent sessions
ps aux | grep hermes       # Running processes
```

---

## Anti-Patterns (What NOT to Do)

❌ **Don't** run multiple `hermes` in same terminal without `HERMES_CONFIG_DIR`
- They'll conflict on `~/.hermes/` lock files

❌ **Don't** manually edit `~/.hermes/` while agents are running
- Use `hermes config set` instead

❌ **Don't** forget to set `tenant=` when using multi-tenant
- Pass `tenant=os.environ.get("HERMES_TENANT")` in kanban_create()

❌ **Don't** spawn infinite loops of agents
- `delegate_task` has depth limits, but be careful!

---

**Next step**: Want me to demonstrate a swarm by spawning 3 workers to do different tasks?
