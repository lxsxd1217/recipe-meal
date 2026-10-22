-- WARNING: by uncommenting the script below and running the full script will delete everything already existed
-- drop table if exists saved_recipes;
-- drop table if exists recipes;

create table if not exists recipes (
    meal_id int primary key,
    meal_name VARCHAR(255) not null,
    thumbnail VARCHAR(255),
    category VARCHAR(255),
    cuisine VARCHAR(255),
    recipe jsonb not null
);

create table if not exists saved_recipes (
    client_id VARCHAR(255) not null,
    meal_id int not null,
    saved_time timestamptz not null default now(),
    primary key (client_id, meal_id),
    foreign key (meal_id) references recipes(meal_id) on delete cascade
);

alter table recipes enable row level security;
alter table saved_recipes enable row level security;
-- what is allowed for everyone to access
drop policy if exists "read recipes" on recipes;
create policy "read recipes" on recipes for select using (true);

drop policy if exists  "insert recipes" on recipes;
create policy "insert recipes" on recipes for insert with check (true);

drop policy if exists "read saved" on saved_recipes;
create policy "read saved" on saved_recipes for select using (true);

drop policy if exists "insert saved" on saved_recipes;
create policy "insert saved" on saved_recipes for insert with check (true);

drop policy if exists "delete saved" on saved_recipes;
create policy "delete saved" on saved_recipes for delete using (true);