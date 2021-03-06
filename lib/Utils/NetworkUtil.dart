import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkUtil
{
	final JsonDecoder oJsonDecoder = new JsonDecoder();

	Future<dynamic> get (String url)
	{
		return http.get (url).then ((http.Response response)
		{
			final String res = response.body;
			final int statusCode = response.statusCode;

			if (statusCode < 200 || statusCode > 400 || json == null)
			{
				throw new Exception("Error while fetching data");
			}
			return oJsonDecoder.convert (res);
		});
	}

	Future<dynamic> post (String url, {Map headers, body, encoding})
	{
		return http
				.post (url, body: body, headers: headers, encoding: encoding)
				.then ((http.Response response)
		{
			final String res = response.body;
			final int statusCode = response.statusCode;

			if (statusCode < 200 || statusCode > 400 || json == null)
			{
				throw new Exception("Error while fetching data");
			}
			return oJsonDecoder.convert (res);
		});
	}
}
