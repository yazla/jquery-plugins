$.rest_ajax = {
	_request : (method, url, data, cb) ->
		$.ajax({
			type : method,
			url : url,
			data : if method == 'get' then data else JSON.stringify(data),
			contentType : 'application/json'
		}).done((response) ->
			cb?(response)
		).fail((jqXHR, textStatus) ->
			cb?(null, {error : jqXHR.response})
		)
}

for methodName in ['get', 'post', 'put', 'delete']
	do (methodName) ->
		$.rest_ajax[methodName] = () ->
			args = Array.prototype.concat.apply([methodName], arguments)
			@_request.apply(this, args)