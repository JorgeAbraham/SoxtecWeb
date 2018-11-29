<!DOCTYPE html>
<html lang="en"><head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="keywords" content="">
        <meta name="author" content="">

        <title>

            Soxtec Connected

        </title>

        
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,400italic" rel="stylesheet">
        <% String host=application.getInitParameter("host");  %>
        <link href="<% out.println(host); %>assets/css/toolkit-inverse.css" rel="stylesheet">
        <link href="<% out.println(host); %>assets/css/bootstrap.min.css" rel="stylesheet">

        <link href="<% out.println(host); %>assets/css/font-awesome.css" rel="stylesheet">
        <link href="<% out.println(host); %>assets/css/application.css" rel="stylesheet">
       
        <link href="<% out.println(host); %>assets/css/progressBar/examples.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            /* note: this is a hack for ios iframe for bootstrap themes shopify page */
            /* this chunk of css is not part of the toolkit :) */
            body {
                width: 1px;
                min-width: 100%;
                *width: 100%;
                 background-color: #F0F0F0;
                 color: #000000;
            }
        </style>
        
        
        
        <script src="<% out.println(host); %>assets/js/jquery.min.js"></script>
        
    </head>

    <body bgcolor="#E6E6FA">