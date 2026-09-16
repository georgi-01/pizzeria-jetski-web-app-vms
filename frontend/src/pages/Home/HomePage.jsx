function HomePage() {
  return (
    <main>
      <section>
        <h1>Welcome to Pizzeria Jetski</h1>

        <p>
          Добре дошли в уеб приложението на Pizzeria Jetski.
        </p>

        <button type="button">
          Направи поръчка
        </button>
      </section>

      <section>
        <h2>Бързи действия</h2>

        <div>
          <button type="button">
            Нова поръчка
          </button>

          <button type="button">
            История на поръчките
          </button>

          <button type="button">
            Промоции
          </button>
        </div>
      </section>
    </main>
  );
}

export default HomePage;
