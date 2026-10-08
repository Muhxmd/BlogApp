// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

document.addEventListener("turbo:load", () => {
  const searchInput = document.querySelector('input[name="q"]');

  if (!searchInput) return;

  searchInput.addEventListener("search", () => {
    if (searchInput.value === "") {
      const url = new URL(window.location.href);

      url.searchParams.delete("q");

      window.history.replaceState({}, "", url);
      window.location.reload();
    }
  });
});