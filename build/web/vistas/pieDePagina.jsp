


 
<script src="http://code.jquery.com/jquery-latest.js"></script>


<% String host=application.getInitParameter("host");  %>


<script src="<% out.println(host); %>assets/js/popper.min.js"></script>
<script src="<% out.println(host); %>assets/js/popper.js"></script>
<script src="<% out.println(host); %>assets/js/tooltip.js"></script>
<script src="<% out.println(host); %>assets/js/chart.js"></script>
<script src="<% out.println(host); %>assets/js/tablesorter.min.js"></script>
<script src="<% out.println(host); %>assets/js/toolkit.js"></script>
<script src="<% out.println(host); %>assets/js/application.js"></script>



<script src="<% out.println(host); %>assets/js/progressBar/radial-progress-bar.js"></script>
<script src="<% out.println(host); %>assets/js/progressBar/examples.js"></script>


<script>
    // execute/clear BS loaders for docs
    $(function () {
        while (window.BS && window.BS.loader && window.BS.loader.length) {
            (window.BS.loader.pop())()
        }
    })
</script>

</body>
</html>
