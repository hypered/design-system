# Design System

This is a repository for the (early state) web design system for Hypered SPRL.

The current example content (located in the `docs/` directory) is raw HTML and
CSS (using Tachyons). It is visible at
[hypered.github.io/design-system](https://hypered.github.io/design-system/).

A component explorer based on [Storybook](https://storybook.js.org/) is visible
at
[storybook-static.andyngo1.now.sh](https://storybook-static.andyngo1.now.sh/).

The same components, but rendered using `blaze-html`, are visible at
[hypered.github.io/design-system/components/](https://hypered.github.io/design-system/components/).

A Next.js-based site to quickly experiment with the current design and new
components is visible at
[noteed-next.andyngo1.now.sh](https://noteed-next.andyngo1.now.sh/).

Interesting pages are:

- [sprint-2](https://noteed-next.andyngo1.now.sh/sprint-2)
- [blog](https://noteed-next.andyngo1.now.sh/blog)
- [blog post](https://noteed-next.andyngo1.now.sh/blog/starting-with-nixops-1)
- [not-os](https://noteed-next.andyngo1.now.sh/projects/not-os)
- [waveguide](https://noteed-next.andyngo1.now.sh/projects/waveguide)
- [nubs-bash](https://noteed-next.andyngo1.now.sh/nubs-bash)
- [nubs-bash/hello](https://noteed-next.andyngo1.now.sh/nubs-bash/hello)


## Notes

There is also a custom Revealjs template that (should) match the design-system.

The `docs/` directory is used because this repository can then use the GitHub
Pages feature from the `master` branch.


## xelatex PDF example

In the `xelatex/` directory, run:

```
$ nix-build
```

The resulting PDF file is then `result/example.pdf`.


## Elsewhere

- The [IBM design system](https://www.carbondesignsystem.com/) is open source.


# Next.js and Storybook

A design system for Hypered. Built with next.js.

---

## Getting Started

Install dependencies using:

```
npm install
```

or

```
yarn install
```

---

## Running the site locally

### Next.js

To run the Next.js site, use `npm run dev` or `yarn run dev`:

```
npm run dev
```

or

```
yarn run dev
```

This will run Next.js on port `3000` on your machine.

### Storybook.js

To run Storybook.js, use `npm run storybook` or `yarn run storybook`:

```
npm run storybook
```

or

```
yarn run storybook
```

This will run Storybook on port `6006` on your machine.

---

## Build

### Next.js

To build the Next.js pages, run `npm run build` or `yarn run build`:

```
npm run build
```

or

```
yarn run build
```

###

To build the Storybook.js pages, run `npm run build-storybook` or `yarn run build-storybook`:

```
npm run build-storybook
```

or

```
yarn run build-storybook
```

---

## Miscellaneous

### telemetry

> Next.js collects completely anonymous telemetry data about general usage. Participation in this anonymous program is optional, and you may opt-out if you'd not like to share any information.

If you'd like to opt-out of telemetry, run the following command in the root of your project directory:

```
npx next telemetry disable
```

To check the status of telemetry, run `next telemetry status` in the root of your project directory:

```
npx next telemetry status
```

For more information, please visit: https://nextjs.org/telemetry
