# Recipe Finder
A minimalist Single Page Application (SPA) designed to help users quickly discover meals based on ingredients they already have on hand.

## Installation & Setup
1. Clone the repository:
```
git clone https://github.com/lxsxd1217/recipe-meal.git
mv recipe-meal recipe-finder
cd recipe-finder
```
2. Initialize your SQL relational database schema to support saved recipe queries (see [Database Setup](#database-setup) below). You can skip this step to try the app first; saved recipes then stay in your browser's localStorage instead of the database.
3. Serve `webpage.html` through a local web server (for example `python3 -m http.server`, then open `http://localhost:8000/webpage.html`) or open it directly in your browser.

## Key Features
- **Search-First Minimalist Interface**: Enter available ingredients or preferred cuisines directly into the search bar.
- **Filter Options**: Narrow down results using category and cuisine dropdowns and dietary filters (vegetarian, vegan, gluten-free, dairy-free, nut-free). Dietary tags are estimated from ingredient names, so check the ingredient list if you have allergies.
- **Visual Meal Grid**: Displays matching recipe cards with thumbnails, titles, and concise tags.
- **Interactive Detail Popup**: Click any recipe card to open a modal window containing full ingredient lists and step-by-step instructions. Click the X in the top-right corner of the popup to close it.
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
- **External API**: [TheMealDB API](https://www.themealdb.com/) for searching recipes by ingredient, category, or area/cuisine (requires zero authentication)

## Database Setup
The app stores saved recipes in a Postgres database hosted on [Supabase](https://supabase.com) (free tier).
 
1. Create a Supabase project. It comes with one database, so you only need to create tables, not a new database.
2. Open **SQL Editor**, paste the contents of `localsave.sql`, and click **Run**.
3. Open **Table Editor** and confirm that `recipes` and `saved_recipes` appear.
4. Go to **Project Settings > API**, copy the **Project URL** and your **publishable key** (it starts with `sb_publishable_`), and paste them into `config.js`:
```js
window.SUPABASE_CONFIG = { url: "https://YOUR-PROJECT.supabase.co", key: "sb_publishable_YOUR-KEY" };
```
5. Reload the app. The note in the saved recipes sidebar should say **Saved to your SQL database.**
6. Test it: save a recipe, then check that one row appears in each table.

## SQL Tables
**`recipes`** holds one row per dish, so a dish's details are stored and edited in one place.
 
| Column | Type | Purpose |
|---|---|---|
| `meal_id` | int, primary key | TheMealDB's ID for the dish |
| `meal_name` | VARCHAR(255), required | Dish title |
| `thumbnail` | VARCHAR(255) | Image URL |
| `category` | VARCHAR(255) | Type of dish (e.g. Dessert, Seafood) |
| `cuisine` | VARCHAR(255) | Region or country the dish comes from (e.g. Italian) |
| `recipe` | jsonb, required | Ingredients, steps, and links |
 
**`saved_recipes`** records which browser saved which dish.
 
| Column | Type | Purpose |
|---|---|---|
| `client_id` | VARCHAR(255), required | Random ID created once per browser (there is no login) |
| `meal_id` | int, required | Foreign key to `recipes(meal_id)` and deleted automatically if the dish is deleted |
| `saved_time` | timestamptz, default now() | When it was saved and used to list newest first |
 
The primary key `(client_id, meal_id)` prevents the same browser saving the same dish twice.

### Running the script again
- The script is safe to run more than once. Existing tables and their data are kept, and the access policies are replaced.
- If you change the table columns, uncomment the two `drop table` lines at the top of `localsave.sql` and run it once. This **deletes all saved recipes**. Comment the lines out again afterwards.

### Access rules
Row Level Security is on for both tables. The policies allow everyone to read dishes and saved links, add dishes and saved links, and remove saved links. Because the app has no user accounts, anyone with the public key could read all saved rows, which is acceptable for a class project. Use Supabase Auth if you need private lists.

### Troubleshooting
| Problem | Fix |
|---|---|
| The sidebar says "Saved in this browser only" | `config.js` is missing your URL or key, or the page was not reloaded after you added them. |
| Saving fails with "column does not exist" | An older version of the tables exists. Uncomment the two `drop table` lines in `localsave.sql`, run it once, then comment them out again. |
| Saving fails right after running the SQL | Supabase may not have noticed the new tables yet. Run `notify pgrst, 'reload schema';` in the SQL Editor and try again. |
 
## Limitations
- Dietary tags are estimates based on ingredient names, not verified information.
- Each search shows at most 36 recipes.
- There are no user accounts, so saved lists are tied to the browser rather than to a person.

## Credits & License
Recipe data and images come from [TheMealDB](https://www.themealdb.com/). Released under the CC0-1.0 license (see `LICENSE`).

**Author**: Anna Lin
