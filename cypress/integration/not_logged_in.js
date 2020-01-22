describe('Not logged in actions', function () {
  beforeEach(function () {
    // before each test, we can automatically preserve the
    // 'session_id' and 'remember_token' cookies. this means they
    // will not be cleared before the NEXT test starts.
    //
    // the name of your cookies will likely be different
    // this is just a simple example
    Cypress.Cookies.debug(true)
    Cypress.Cookies.preserveOnce('_elixirvictoria_key')
  })

  it('Visits the main page', function () {
    cy.visit('http://localhost:5000')
    cy.contains('Supporting and growing the Elixir programming community in the Greater Victoria Area')
  })
})
