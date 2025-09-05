# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a static portfolio website built with vanilla HTML, CSS, and JavaScript. The site is designed to showcase professional information, experience, skills, and contact details in a modern, responsive layout.

## Architecture

The codebase follows a simple three-file structure:

- **index.html**: Single-page application with semantic sections (hero, about, experience, skills, education, contact)
- **styles.css**: CSS-first approach with custom properties, grid/flexbox layouts, and mobile-first responsive design
- **script.js**: Vanilla JavaScript for interactive features and animations

## Key Design Patterns

### CSS Architecture
- Mobile-first responsive design with breakpoints at 768px and 480px
- CSS Grid for main layouts, Flexbox for component-level layouts
- Custom CSS animations and transitions (no external animation libraries)
- Color scheme centered around primary color `#4f46e5` (indigo)

### JavaScript Features
- Intersection Observer API for scroll-triggered animations
- Mobile hamburger navigation with smooth transitions
- Contact form validation and submission handling
- Header scroll behavior (hide/show on scroll)

### Content Structure
The website follows a standard portfolio layout:
- Hero section with name, title, description, and call-to-action
- Timeline-based experience section with visual indicators
- Tag-based skills display grouped by categories
- Card-based education section
- Contact section with both contact info and form

## Development Commands

To view the website:
```bash
open index.html
```

For local development with live reload, use any static server:
```bash
# Python
python -m http.server 8000

# Node.js (if http-server is installed)
npx http-server

# VS Code Live Server extension
# Right-click index.html → "Open with Live Server"
```

## External Dependencies

- **Inter font family** from Google Fonts
- **Font Awesome 6.0.0** for icons
- No JavaScript frameworks or build tools

## Customization Guidelines

When updating content:
- Replace placeholder text in HTML with actual professional information
- Update the profile image URL in the hero section
- Modify the LinkedIn URL in the hero buttons and contact section
- Add/remove timeline items in the experience section
- Update skill tags in the skills section categories
- Replace contact information in the contact section

The design system uses consistent spacing, typography, and color variables throughout the CSS for easy theme modifications.