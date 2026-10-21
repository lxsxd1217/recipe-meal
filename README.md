# Recipe Finder
A minimalist Single Page Application (SPA) designed to help users quickly discover meals based on ingredients they already have on hand.

## Installation & Setup
1. Clone the repository:
```git clone https://github.com/lxsxd1217/recipe-meal.git```
```mv recipe-meal recipe-finder```
```cd recipe-finder```
3. Initialize your SQL relational database schema to support saved recipe queries.
4. Serve ```blank.html``` through a local web server or open it directly in your browser.

## Key Features
- **Search-First Minimalist Interface**: Enter available ingredients or preferred cuisines directly into the search bar.
- **Filter Options**: Narrow down results using category dropdowns or filter options for cuisine types and dietary restrictions.
- **Visual Meal Grid**: Displays matching recipe cards with thumbnails, titles, and concise tags.
- **Interactive Detail Popup**: Click any recipe card to open a modal window containing full ingredient lists and step-by-step instructions.
- **Saved Recipe Collection**: Save favorite recipes to a persistent sidebar collection backed by a database for easy retrieval.
- **About & Help Views**: Integrated guides providing project background, mission details, and interactive system instructions.  

## System Workflow
1. **Search & Filter**: User inputs an ingredient/cuisine or applies a filter in the UI.
2. **Fetch Data**: The frontend requests matching recipe data from TheMealDB API.
3. **Render Results**: Results populate dynamically in a thumbnail grid display.
4. **Inspect Recipe**: Clicking a meal card displays a popup modal with ingredients and instructions.
5. **Bookmark Dish**: Clicking "Save" sends an insertion request to store the recipe in the SQL database.
6. **View Collection**: The saved recipes sidebar issues a fetch request to display stored favorites.

## Tech Stack & Architecture
- **Frontend**: Standard HTML, CSS, and Pure JavaScript
- **Database**: SQL Relational Database for storing and retrieving bookmarked user recipes
- **External API**: [TheMealDB API] (https://www.themealdb.com/) for searching recipes by ingredient, category, or area/cuisine (requires zero authentication)

**Author**: Anna Lin
