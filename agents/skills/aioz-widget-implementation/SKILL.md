---
name: aioz-global-map-widget-implementation
description: AIOZ Global Map Widget implementation guideline for
  - Service implementation
  - Data fetch implementation
  - UI implementation
metadata:
  author: thuanpvaioz
  version: "1.0.0"
---

# Common knowledge about AIOZ Global Map

AIOZ Global Map consist of many templates, each template have many widgets with specific layout.

# Service implementation

Each widget will depend on a service. Before implementing a widget's service, define a interface of this service first. The service must be inheritance from `UrlBuilder class` and the previous defined service.
For define response type of service, must read from the mock data (if have).

## Rules file and name conventions:

- File of type definition must be placed in `@/types/<service-name>.ts`, file of service must be placed in `@/services/<service-name>.ts`.
- File of mock data must be placed in `@/mocks/<service-name-[sub-content]>.json`

# Data fetching implementation

The usage of each service from a custom hook using from the `react-query` lib.

## Rules of custom hook's name and implementation:

- Folder location `@features/` or `@/hooks`
- Define a UI interface props type depend on the response type of the used service. (ENSURE THE UI LAYER DO NOT CRASH IF THE RESPONSE FROM SERVICE BE CHANGED). This type will be used in the `select` function of `useQuery`.

# UI implementation

Switch to plan mode to brainstorming how to express the data into the UI. I will give to you a recommend UI/UX via an image.

## Rules of UI/UX pattern:

- For each widget, it be pre-configurated a color, you can use it via components `@/features/widget-theme/*`
- Filter must be using `ButtonGroup` of `shadcn-ui`
