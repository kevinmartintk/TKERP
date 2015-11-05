Headquarter.create([
  {
    country: Country.find_by_name('Peru'),
    image: File.open(File.join(Rails.root, "app/assets/images/countries/peru.png"))
  },
  {
    country: Country.find_by_name('United States'),
    image: File.open(File.join(Rails.root, "app/assets/images/countries/usa.png"))
  },
  {
    country: Country.find_by_name('Mexico'),
    image: File.open(File.join(Rails.root, "app/assets/images/countries/mexico.png"))
  }
])