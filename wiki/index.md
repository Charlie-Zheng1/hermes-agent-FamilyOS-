# wiki/ - Personal Knowledge Base

Interlinked markdown wiki of everything you know — people, companies, projects, ideas.

## Structure

| Directory | Purpose |
|-----------|---------|
| `people/` | One page per human being |
| `companies/` | One page per organization |
| `projects/` | Things being actively built |
| `concepts/` | Mental models and frameworks |
| `meetings/` | Records of specific events |
| `ideas/` | Raw possibilities nobody is building yet |
| `writing/` | Prose artifacts (essays, philosophy) |
| `programs/` | Major life workstreams |
| `personal/` | Private notes, health, reflections |
| `inbox/` | Unsorted quick captures (temporary) |
| `archive/` | Dead pages, historical record |
| `sources/` | Raw data imports and API responses |
| `prompts/` | Reusable LLM prompt library |

## How to Use

1. **Before creating any page** → read `RESOLVER.md` (master decision tree)
2. **Before filing in a directory** → read that directory's `README.md`
3. **Page structure**: Compiled Truth (above `---`) + Timeline (below `---`)
4. **Search first**: `grep -ri "name" wiki/` before creating new pages

## Quick Commands

```bash
# Import into GBrain
gbrain import ~/code/hermes/wiki/

# Generate embeddings (requires API key for vector search)
gbrain embed --stale

# Query the brain
gbrain query "what do I know about machine learning?"
```

## Key Principles

- **MECE directories**: Every piece of knowledge has exactly one primary home
- **One page per entity**: Use canonical slugs, aliases for variants
- **Compiled truth + timeline**: Synthesis above, evidence below
- **Enrichment fires on every signal**: Meetings, emails, social media auto-update pages
