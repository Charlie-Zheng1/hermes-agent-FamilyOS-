# AU Bot-Prone Sites & Fallback Sources

## High-Risk Sites (Aggressive Bot Detection)
| Site | Detection Type | Notes |
|------|------------------|-------|
| Whirlpool Forums | Cloudflare | Blocks curl, headless browsers within 1-2 requests |
| ProductReview.com.au | Cloudflare | Returns "Attention Required" to automated agents |
| Reddit (r/TeslaModelY, r/Australia) | Google reCAPTCHA | Headless browser access triggers CAPTCHA |
| Tesla Australia (tesla.com/en_au) | Google Access Denied | Blocks most non-residential IPs |
| Google Search (AU-specific queries) | Bot detection | Returns truncated output or "Prove you're human" |

## Pre-Vetted Fallback Sources (Bot-Friendly)
- **Wikipedia**: AU-localized pages (e.g., Tesla_Model_Y) – no bot checks
  - *Note for Tesla Model Y paint queries*: Lacks AU-specific paint details; prioritize CarExpert and session_search first.
- **CarExpert.com.au**: Public automotive reviews, minimal bot blocking
- **Drive.com.au**: Australian automotive news, accessible to headless browsers
- **Wikipedia General**: For technical specs, historical context
- **Session Search**: Check `session_search` for prior research before attempting blocked sites

## Cron Job Considerations
For scheduled jobs with no user present:
1. Skip any site requiring CAPTCHA/ human verification
2. Use fallbacks first, only attempt high-risk sites if fallbacks are insufficient
3. Limit requests to 1-2 per high-risk site before switching to fallbacks