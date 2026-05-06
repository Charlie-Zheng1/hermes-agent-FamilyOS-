---
name: australian-market-research
category: research
description: Strategies for researching Australian market topics (automotive, consumer products, local services) with mitigations for aggressive bot detection on AU-specific forums and review sites.
---

# Australian Market Research

## Trigger Conditions
Load this skill when tasked with researching Australian-specific topics: consumer products, automotive, local services, user feedback from AU forums, or any query mentioning "Australia" or AU-specific regions.

## Core Workflow
1. **Prioritize bot-friendly sources first**:
   - Wikipedia (AU-localized pages)
   - Australian automotive media: CarExpert, Drive, CarAdvice, Chasing Cars
   - Public news sites (ABC, The Guardian Australia) with open access
   - Tesla Australia official site (if accessible, note: often blocks automated agents)

2. **Expect aggressive bot detection**:
   - AU forums (Whirlpool, ProductReview.com.au) use Cloudflare/Google Advanced Protection
   - Reddit AU communities (r/TeslaModelY, r/Australia) trigger CAPTCHA for headless browsers
   - Australian government/regulated sites (e.g., ACMA) may block non-residential IPs

3. **Fallback strategies for blocked sources**:
   - Use `session_search` to check for prior research on the same topic
   - Combine general domain knowledge with snippets from accessible sources
   - For cron jobs: Skip sites requiring human verification (no user present to solve CAPTCHAs)
   - Use terminal `curl` with minimal headers only as a last resort (most AU sites block non-browser user agents)

4. **Verification**:
   - Cross-reference findings across 2+ accessible sources
   - Note when data is inferred from general knowledge due to blocked sources

5. **Efficient term scanning for reviews**:
   - When checking long review pages for specific terms (e.g., paint, color, heat reflection), use `browser_console` with JavaScript queries like `document.body.innerText.includes('paint')` to quickly verify term presence without manual scrolling.

## Pitfalls
- Do not waste time trying to bypass Cloudflare/Google bot checks for AU forums – they are designed to block automated agents
- Tesla Australia's official site (tesla.com/en_au) returns "Access Denied" to most automated agents
- Whirlpool and ProductReview.com.au will block curl requests and headless browser sessions within 1-2 requests
- Avoid rapid successive requests to any AU site to prevent IP-based blocking
- Google.com.au search for specific product comparison queries triggers bot detection immediately, returning "Prove you're human" pages. Skip Google AU search for niche AU product research.

## References
- `references/au-bot-prone-sites.md`: List of high-risk AU sites and pre-vetted fallback sources
- `references/tesla-au-paint-research.md`: Condensed findings from this session's Tesla Model Y paint research