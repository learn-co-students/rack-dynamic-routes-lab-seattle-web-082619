require 'pry'

class Application

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        @@item = Item.all
        # binding.pry
        if req.path.match(/items/)
            item_instance = @@item.find { |i| i.name == req.path.split("/items/").last }
            if item_instance
                resp.write item_instance.price
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end

end
