# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Static portfolio website with a Supabase-backed blog. No build tools — everything is vanilla HTML, CSS, and JavaScript served directly by Vercel.

## File Structure

- **index.html** — Single-page portfolio (hero, about, services, experience, skills, education, contact)
- **blog.html** — Public blog: list view (default) and single post view (`?post=slug`)
- **admin.html** — Private blog admin: login, CRUD editor with live Markdown preview and image uploads
- **styles.css** — All styles for all three pages (sections: base → portfolio → blog → admin)
- **script.js** — Portfolio-only JS (Intersection Observer animations, hamburger nav, header scroll)
- **schema.sql** — Run once in Supabase SQL Editor to create the `posts` table and RLS policies
- **CVs/** — Downloadable CV PDFs

## Architecture

### Routing
`blog.html` and `admin.html` are separate pages. Blog post routing uses query params (`?post=slug`) — no server-side routing needed, works on Vercel static hosting.

### Supabase Integration
Both `blog.html` and `admin.html` load the Supabase JS SDK from CDN and initialise the client with hardcoded constants at the top of each `<script>` block:
```js
const SUPABASE_URL = 'https://npkhtmdicvdeyhxvenzl.supabase.co';
const SUPABASE_KEY = 'sb_publishable_...';
```
The publishable key is safe to be public. The `posts` table uses Row Level Security: anyone can read published posts (`is_published = true`), only authenticated users can write.

### Blog Admin Auth
`admin.html` uses `db.auth.onAuthStateChange` to gate the UI — no session means the login screen shows. Admin accounts are created manually in the Supabase dashboard (Authentication → Users). There is no signup form.

### Image Uploads
Images are stored in the `blog-images` Supabase Storage bucket (public). `admin.html` supports three upload methods: file picker button (cover image), toolbar button (inserts at cursor), and Ctrl+V paste into the editor textarea.

### CSS Layout
- Primary colour: `#4f46e5` (indigo)
- Breakpoints: 768px (tablet) and 480px (mobile)
- Portfolio sections alternate between `background: #ffffff` and `.section-alt` (light grey gradient)
- Blog and admin styles are appended at the end of `styles.css` under clearly marked comment blocks

## Development

```bash
# Serve locally
python -m http.server 8000
# or
npx http-server
```

Admin panel requires a live Supabase connection — it will not work by opening `admin.html` directly as a `file://` URL due to CORS. Use a local server.

## Deployment

Vercel auto-deploys on push to `main` (GitHub: `ahmarmahmood/ahmar-portfolio`). No build step — files are served as-is.

```bash
git push origin main
```

The project is linked to the "Ahmar Mahmood's projects" Vercel team (`ahmaraimy-6217`). Live at `https://www.ahmarmahmood.com`.

## External Dependencies (CDN only)

- Google Fonts — Inter
- Font Awesome 6.0.0 — icons
- `@supabase/supabase-js@2` — database + auth + storage (`blog.html`, `admin.html`)
- `marked@9` — Markdown → HTML rendering (`blog.html`, `admin.html`)
- `dompurify@3` — sanitise rendered HTML (`blog.html`, `admin.html`)

## Supabase Setup (one-time)

1. Run `schema.sql` in Supabase SQL Editor
2. Create Storage bucket named `blog-images` with public access enabled
3. Create admin user: Supabase dashboard → Authentication → Users → Add user
