package com.course.servicemesh.frontend.courseservicemeshfrontend.controllers;

import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.asynchttpclient.AsyncHttpClient;
import org.asynchttpclient.DefaultAsyncHttpClientConfig;
import org.asynchttpclient.Dsl;
import org.asynchttpclient.ListenableFuture;
import org.asynchttpclient.Request;
import org.asynchttpclient.RequestBuilder;
import org.asynchttpclient.Response;
import org.asynchttpclient.util.HttpConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Hashtable;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("api/v1/dashboard")
public class DashboardController {

    private final static Logger logger = LoggerFactory.getLogger(DashboardController.class);

    @GetMapping
    public Hashtable<String, Object> getDashboard() throws ExecutionException, InterruptedException, ParseException {

        logger.info("Incoming request for dashboard route");
        DefaultAsyncHttpClientConfig.Builder clientBuilder = Dsl.config().setConnectTimeout(500);
        AsyncHttpClient client = Dsl.asyncHttpClient(clientBuilder);
        Request authorsRequest = new RequestBuilder(HttpConstants.Methods.GET)
                .setUrl("http://authors:8080/api/v1/authors")
                .build();

        Request booksRequest = new RequestBuilder(HttpConstants.Methods.GET)
                .setUrl("http://books:8080/api/v1/books")
                .build();

        ListenableFuture<Response> authorsFuture = client.executeRequest(authorsRequest);
        ListenableFuture<Response> booksFuture = client.executeRequest(booksRequest);
        Response authorsResponse = authorsFuture.get();
        Response booksResponse = booksFuture.get();

        Hashtable<String, Object> clientResponse = new Hashtable<>();
        clientResponse.put("authors", new JSONParser(authorsResponse.getResponseBody()).parse());
        clientResponse.put("books", new JSONParser(booksResponse.getResponseBody()).parse());
        return clientResponse;
    }
}
