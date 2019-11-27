alias Cookbook.Repo
alias Cookbook.Menu.Meal
alias Cookbook.Scraper.HelloFresh

year_week_tuples = for(year <- 2017..2019, week <- 1..52, do: {year, week})

all_meals =
  Enum.flat_map(year_week_tuples, fn {year, week} ->
    IO.write("Scraping #{year} week #{week} ... ")
    meals = HelloFresh.scrape(year, week)
    IO.puts("done.")
    meals
  end)

Repo.transaction(fn ->
  Enum.each(all_meals, fn meal ->
    Repo.insert!(
      Meal.changeset(%Meal{}, meal),
      on_conflict: {:replace, ~w[img_url time note last_seen updated_at]a},
      conflict_target: :name
    )
  end)
end)
