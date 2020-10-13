[
  tools: [
    {:formatter, command: "mix format"},
    {:cypress, command: "mix cypress.run"},
    {:sobelow, command: "mix sobelow --config"},
    {:credo, command: "mix credo --strict"},
    {:ex_unit, command: "mix test", env: %{"MIX_ENV" => "test"}}
  ]
]
