# people/ - One Page Per Human Being

## What Goes Here

Pages about **individual human beings** - employees, founders, investors, friends, family, contacts, meeting attendees.

**Positive test**: Is this about a *specific person as a human*? If yes → this directory.

**File naming**: `first-last.md` (all lowercase, hyphens for spaces)
- Example: `john-doe.md`, `jane-smith.md`
- Collisions: `david-liu-crustdata.md`, `david-liu-meta.md`

## What Does NOT Go Here

- **Companies they work for** → `companies/` (link to them, don't put company info here)
- **Projects they're building** → `projects/` (link to them)
- **Concepts they believe in** → `concepts/` (link to them)
- **Meetings you had with them** → `meetings/` (link to their page)
- **Organizations they belong to** → `companies/` or create the org page there

**Key distinction**: This page is about *them as a human* - their beliefs, communication style, motivations, relationship to you. Company info, projects, and ideas have their own pages and link here.

## Page Structure

Every person page should have these sections:
- Executive summary (above the line)
- State (role, company, relationship)
- What They Believe
- What They're Building
- What Motivates Them
- Communication Style
- Assessment
- Network
- Open Threads
- --- (horizontal rule)
- Timeline (below the line, append-only)

## Raw Data

Each person can have a `.raw/` sidecar directory for API responses:
```
people/john-doe.md
people/.raw/john-doe.json
```

## Before Creating a New Page

1. Search existing pages: `grep -ri "john doe" people/`
2. Check aliases in frontmatter of existing pages
3. If match found → UPDATE existing page (add alias if new name variant)
4. If no match → CREATE new page
