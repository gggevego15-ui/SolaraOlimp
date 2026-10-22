# Solara Olimp 1.1.0

Solara Olimp is a static single-page app backed by Supabase Edge Functions.

## Free production hosting: Cloudflare Pages

The project is prepared for Cloudflare Pages. It uses the free `pages.dev` domain and Git integration; no paid plan, server, build secret, or custom domain is required.

1. Sign in to Cloudflare and open **Workers & Pages**: https://dash.cloudflare.com/
2. Choose **Create application → Pages → Connect to Git**.
3. Authorize the Cloudflare GitHub app for the repository `gggevego15-ui/SolaraOlimp`.
4. Select branch `main`.
5. Set **Build command** to `npm run build`.
6. Set **Build output directory** to `dist`.
7. Deploy. Cloudflare will provide a free `*.pages.dev` URL and deploy future commits automatically.

The build script copies only `index.html`, `_headers`, and `_redirects` into `dist/`. It deliberately does not publish the `.github/` workflows, Supabase function source, database migrations, or repository documentation.

### Local build check

Requires Node.js 20 or newer:

```sh
npm run build
```

### Backend

The browser uses the existing Supabase Edge Function at `olimp-api`. Static hosting does not replace the backend. The public publishable key is intended for browser use; server-side secrets must never be placed in `index.html`.

### After Cloudflare is confirmed live

Keep GitHub Pages enabled only as a temporary fallback until the `pages.dev` site and its live API are verified. Then disable GitHub Pages in **Repository Settings → Pages** to avoid publishing the same site from two providers.
