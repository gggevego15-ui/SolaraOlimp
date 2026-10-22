# Solara Olimp 1.1.0

Solara Olimp is a static single-page app backed by Supabase Edge Functions.

## Free production hosting: Netlify

The project is configured for Netlify's Free plan. It provides a free `*.netlify.app` address, HTTPS, Git-based automatic deployments, and no requirement to buy a custom domain. The Free plan has a hard monthly limit of 300 usage credits; if the limit is reached, projects pause until the next billing cycle, and Free usage cannot incur charges.

1. Open Netlify: https://app.netlify.com/
2. Choose **Add new project → Import an existing project**.
3. Connect GitHub and authorize access to `gggevego15-ui/SolaraOlimp`.
4. Select branch `main`. Netlify reads `netlify.toml` automatically:
   - Build command: `npm run build`
   - Publish directory: `dist`
5. Deploy the site. If the project is private by default, explicitly publish it so visitors can open it.
6. Copy the actual `*.netlify.app` URL and verify the deployed site before considering the migration complete.

Every new commit to `main` will trigger a deployment after the Git connection is active.

The build script copies only `index.html`, `_headers`, and `_redirects` into `dist/`. It deliberately does not publish the `.github/` workflows, Supabase function source, database migrations, or repository documentation.

### Local build check

Requires Node.js 20 or newer:

```sh
npm run build
```

### Backend

The browser uses the existing Supabase Edge Function at `olimp-api`. Static hosting does not replace the backend. The public publishable key is intended for browser use; server-side secrets must never be placed in `index.html`.

### After Netlify is confirmed live

Keep GitHub Pages enabled only as a temporary fallback until the Netlify site and its live API are verified. Then disable GitHub Pages in **Repository Settings → Pages** to avoid publishing the same site from two providers.
