# Learn Hugo Project

A simple Hugo website built with the PaperMod theme to demonstrate Hugo functionality.

## Getting Started

### Prerequisites

- [Hugo](https://gohugo.io/installation/) (extended version recommended)
- Git

### Running the project

1. Clone this repository
2. Navigate to the project directory
3. Run the development server:
   ```bash
   make server
   ```
4. Visit [http://localhost:1313](http://localhost:1313) in your browser

## Project Structure

- **Theme**: PaperMod
- **Content**:
  - Home page
  - About page
  - Blog posts
  - Projects showcase
  - Contact page
- **Navigation**: Top menu bar with links to all sections

## Making Changes

### Adding Content

- Create new blog posts:
  ```bash
  hugo new posts/your-post-name.md
  ```

- Create new pages:
  ```bash
  hugo new page/your-page-name.md
  ```

### Build for Production

```bash
make build-prod
```

The static site will be generated in the `public/` directory.

## Makefile Commands

- `make server` - Start the development server with draft content
- `make build` - Build the site including draft content
- `make build-prod` - Build the site for production (no drafts)
- `make clean` - Remove the build directory

## Resources

- [Hugo Documentation](https://gohugo.io/documentation/)
- [PaperMod Theme](https://github.com/adityatelange/hugo-PaperMod) 