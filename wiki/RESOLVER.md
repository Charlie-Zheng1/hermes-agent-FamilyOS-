# RESOLVER.md - Master Decision Tree for Filing

Read this file BEFORE creating any new page in the wiki. This decision tree ensures every piece of knowledge goes to exactly one primary home (MECE principle).

## Decision Tree

When you need to file new information, follow this decision tree:

### 1. Is it about a PERSON (human being)?
   - **Yes** → `people/`
   - **Examples**: employees, founders, investors, friends, family, contacts
   - **File format**: `first-last.md` (all lowercase, hyphens)

### 2. Is it about a COMPANY or ORGANIZATION?
   - **Yes** → `companies/`
   - **Examples**: startups, corporations, non-profits, government agencies
   - **File format**: `company-name.md`

### 3. Is it a PROJECT (something being actively built)?
   - **Yes** → `projects/`
   - **Has a repo, spec, or team?** → `projects/`
   - **No one working on it yet?** → `ideas/`

### 4. Is it a CONCEPT (mental model or framework you'd teach)?
   - **Yes** → `concepts/`
   - **Could you teach it as a framework?** → `concepts/`
   - **Is it just a raw possibility?** → `ideas/`

### 5. Is it a MEETING (specific event with transcript)?
   - **Yes** → `meetings/`
   - **Has a transcript or notes?** → `meetings/`

### 6. Is it WRITING (prose artifact like essay, blog post)?
   - **Yes** → `writing/`
   - **Is it a draft, essay, or article?** → `writing/`
   - **Is it a framework/mental model?** → `concepts/`

### 7. Is it PERSONAL (private reflection, health, private notes)?
   - **Yes** → `personal/`
   - **Would you share it in a professional talk?** → NO → `personal/`
   - **Is it about your inner thoughts?** → `personal/`

### 8. Is it a PROGRAM (major life workstream - the forest, not the trees)?
   - **Yes** → `programs/`

### 9. Don't know where it fits?
   - **File in** → `inbox/`
   - **This is a signal** the schema needs to evolve

## Key Disambiguation Rules

| Confusion | Rule |
|-----------|------|
| Concept vs. Idea | Could you *teach* it as a framework? → concept. Could you *build* it? → idea |
| Concept vs. Personal | Would you share it in a professional talk? → concept. Private reflection? → personal |
| Idea vs. Project | Is anyone working on it? Yes → project. No → idea |
| Writing vs. Concepts | Concept = distilled (200 words summary). Writing = developed prose (essay, narrative) |
| Person vs. Company | About *them as a human*? → people/. About *the organization*? → companies/ |

## Important Notes

1. **Every directory has a README.md** - read it before filing there
2. **One page per entity** - use canonical slugs, aliases for variants
3. **Cross-references welcome** - a person page links to their company, projects, etc.
4. **MECE applies to directories, not reality** - people are multi-faceted, but their page lives in one place

## Page Structure (Two-Layer Pages)

Every page has two sections separated by `---`:

**Above the line** - Compiled Truth (always current, rewritten on updates)
- Executive summary
- State fields
- Open Threads (active items)
- See Also (cross-links)

**Below the line** - Timeline (append-only, never rewritten)
- Dated entries with source
- Evidence log
- Resolved threads move here with resolution note
