class Request
  class << self
    def where(resource_path, query = {}, options = {})
      response, status = get_json(resource_path, query)
      status == 200 ? response : errors(response)
    end

    def get_json(root_path, query = {})
      query_string = query.map{|k, v| "#{k}=#{v}"}.join("&")
      path = query.empty?? root_path : "#{root_path}?#{query_string}"
      response = api.get(path)
      [JSON.parse(response.body), response.status]
    end

    def errors(response)
      error = { errors: { status: response["status"], message: response["message"] } }
      response.merge(error)
    end

    def api(source)
      if source == "alpha_vantage"
        Connection.alpha_vantage
      else
        Connection.tradier
      end
    end
  end
end
