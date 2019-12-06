class NoCompanyExists < StandardError
  def http_status
    422
  end

  def code
    "company does not exist"
  end

  def message
    "Request does not pass a symbol matching a company that exists yet (required). Create a stats profile for the company or try a different symbol."
  end
end
