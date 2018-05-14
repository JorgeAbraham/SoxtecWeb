<jsp:include page="cabecera.jsp" flush="true"/>

<div class="bw">
    <div class="dh">
        <div class="en ble">
            <nav class="bll">
                <div class="blf">
                    <button class="bkb bkd blg" type="button" data-toggle="collapse" data-target="#nav-toggleable-md">
                        <span class="yz">Toggle nav</span>
                    </button>
                    <a class="blh bmh" href="index.html">
                        <span class="bv bch bli"></span>
                    </a>
                </div>

                <div class="collapse bki" id="nav-toggleable-md">
                    <form class="blj">
                        <input class="form-control" type="text" placeholder="Search...">
                        <button type="submit" class="ku">
                            <span class="bv bdb"></span>
                        </button>
                    </form>
                    <ul class="nav lq nav-stacked st">
                        <li class="asv">Dashboards</li>
                        <li class="lp">
                            <a class="ln active" href="index.html">Inicio</a>
                        </li>
                        <li class="lp">
                            <a class="ln " href="order-history/index.html">Carga de Información</a>
                        </li>
                        <li class="lp">
                            <a class="ln " href="fluid/index.html">Facturas</a>
                        </li>
                        <li class="lp">
                            <a class="ln " href="icon-nav/index.html">Icon nav</a>
                        </li>

                        <li class="asv">More</li>
                        <li class="lp">
                            <a class="ln " href="docs/index.html">
                                Toolkit docs
                            </a>
                        </li>
                        <li class="lp">
                            <a class="ln" href="http://getbootstrap.com" target="blank">
                                Bootstrap docs
                            </a>
                        </li>
                        <li class="lp">
                            <a class="ln " href="index-light/index.html">Light UI</a>
                        </li>
                        <li class="lp">
                            <a class="ln" href="#docsModal" data-toggle="modal">
                                Example modal
                            </a>
                        </li>
                    </ul>
                    <hr class="bmi aah">
                </div>
            </nav>
        </div>
        <div class="et bmj">
            <div class="bls">
                <div class="blt">
                    <h6 class="blv">Dashboards</h6>
                    <h2 class="blu">Soxtec</h2>
                </div>

                <div class="lf blw">
                    <div class="asr bld">
                        <input type="text" value="01/01/15 - 01/08/15" class="form-control" data-provide="datepicker">
                        <span class="bv awh"></span>
                    </div>
                </div>
            </div>

            <hr class="aah">

            <div class="dh ard aav">
                <div class="eo aaq ahj">
                    <div class="atv acw"><iframe class="chartjs-hidden-iframe" tabindex="-1" style="display: block; overflow: hidden; border: 0px; margin: 0px; top: 0px; left: 0px; bottom: 0px; right: 0px; height: 100%; width: 100%; position: absolute; pointer-events: none; z-index: -1;"></iframe>
                        <canvas class="bkx js-chart-drawn" width="144" height="144" data-chart="doughnut" data-dataset="[230, 130]" data-dataset-options="{ borderColor: '#252830', backgroundColor: ['#1ca8dd', '#1bc98e'] }" data-labels="['Returning', 'New']" style="display: block; width: 144px; height: 144px;">
                        </canvas>
                    </div>
                    <strong class="asd">Traffic</strong>
                    <h4>New vs Returning</h4>
                    <form action="Upload" enctype="MULTIPART/FORM-DATA" method="post">
                        <input type="file" name="file" /><br/>
                        <input type="button" id="submit" class="btn btn-lg btn-primary btn-block" value="Ingresar" /> 
                    </form>
                </div>
                <div class="eo aaq ahj">
                    <div class="atv acw"><iframe class="chartjs-hidden-iframe" tabindex="-1" style="display: block; overflow: hidden; border: 0px; margin: 0px; top: 0px; left: 0px; bottom: 0px; right: 0px; height: 100%; width: 100%; position: absolute; pointer-events: none; z-index: -1;"></iframe>
                        <canvas class="bkx js-chart-drawn" width="144" height="144" data-chart="doughnut" data-dataset="[330,30]" data-dataset-options="{ borderColor: '#252830', backgroundColor: ['#1ca8dd', '#1bc98e'] }" data-labels="['Returning', 'New']" style="display: block; width: 144px; height: 144px;">
                        </canvas>
                    </div>
                    <strong class="asd">Revenue</strong>
                    <h4>New vs Recurring</h4>
                </div>
                <div class="eo aaq ahj">
                    <div class="atv acw"><iframe class="chartjs-hidden-iframe" tabindex="-1" style="display: block; overflow: hidden; border: 0px; margin: 0px; top: 0px; left: 0px; bottom: 0px; right: 0px; height: 100%; width: 100%; position: absolute; pointer-events: none; z-index: -1;"></iframe>
                        <canvas class="bkx js-chart-drawn" width="144" height="144" data-chart="doughnut" data-dataset="[100,260]" data-dataset-options="{ borderColor: '#252830', backgroundColor: ['#1ca8dd', '#1bc98e'] }" data-labels="['Referrals', 'Direct']" style="display: block; width: 144px; height: 144px;">
                        </canvas>
                    </div>
                    <strong class="asd">Traffic</strong>
                    <h4>Direct vs Referrals</h4>
                </div>
            </div>

            <div class="bkz aav aaj">
                <h3 class="bla blb">Quick stats</h3>
            </div>

            <div class="dh bmk">
                <div class="eq fp aaj ahq ano">
                    <div class="bml bks"><iframe class="chartjs-hidden-iframe" tabindex="-1" style="display: block; overflow: hidden; border: 0px; margin: 0px; top: 0px; left: 0px; bottom: 0px; right: 0px; height: 100%; width: 100%; position: absolute; pointer-events: none; z-index: -1;"></iframe>
                        <div class="abw">
                            <span class="bkn">Page views</span>
                            <h2 class="bkm">
                                1,293
                                <small class="bko bkp">5%</small>
                            </h2>
                            <hr class="bkw zo">
                        </div>
                        <canvas id="sparkline1" width="298" height="74" class="bmm js-chart-drawn" data-chart="spark-line" data-dataset="[[28,68,41,43,96,45,100]]" data-labels="['a','b','c','d','e','f','g']" style="width: 298px; height: 74px; display: block;">
                        </canvas>
                    </div>
                </div>
                <div class="eq fp aaj ahq ano">
                    <div class="bml bkv"><iframe class="chartjs-hidden-iframe" tabindex="-1" style="display: block; overflow: hidden; border: 0px; margin: 0px; top: 0px; left: 0px; bottom: 0px; right: 0px; height: 100%; width: 100%; position: absolute; pointer-events: none; z-index: -1;"></iframe>
                        <div class="abw">
                            <span class="bkn">Downloads</span>
                            <h2 class="bkm">
                                758
                                <small class="bko bkq">1.3%</small>
                            </h2>
                            <hr class="bkw zo">
                        </div>
                        <canvas id="sparkline1" width="298" height="74" class="bmm js-chart-drawn" data-chart="spark-line" data-dataset="[[4,34,64,27,96,50,80]]" data-labels="['a', 'b','c','d','e','f','g']" style="width: 298px; height: 74px; display: block;"></canvas>
                    </div>
                </div>
                <div class="eq fp aaj ahq ano">
                    <div class="bml bkt"><iframe class="chartjs-hidden-iframe" tabindex="-1" style="display: block; overflow: hidden; border: 0px; margin: 0px; top: 0px; left: 0px; bottom: 0px; right: 0px; height: 100%; width: 100%; position: absolute; pointer-events: none; z-index: -1;"></iframe>
                        <div class="abw">
                            <span class="bkn">Sign-ups</span>
                            <h2 class="bkm">
                                1,293
                                <small class="bko bkp">6.75%</small>
                            </h2>
                            <hr class="bkw zo">
                        </div>
                        <canvas id="sparkline1" width="186" height="46" class="bmm js-chart-drawn" data-chart="spark-line" data-dataset="[[12,38,32,60,36,54,68]]" data-labels="['a', 'b','c','d','e','f','g']" style="width: 186px; height: 46px; display: block;"></canvas>
                    </div>
                </div>
                <div class="eq fp aaj ahq ano">
                    <div class="bml bku"><iframe class="chartjs-hidden-iframe" tabindex="-1" style="display: block; overflow: hidden; border: 0px; margin: 0px; top: 0px; left: 0px; bottom: 0px; right: 0px; height: 100%; width: 100%; position: absolute; pointer-events: none; z-index: -1;"></iframe>
                        <div class="abw">
                            <span class="bkn">Downloads</span>
                            <h2 class="bkm">
                                758
                                <small class="bko bkq">1.3%</small>
                            </h2>
                            <hr class="bkw zo">
                        </div>
                        <canvas id="sparkline1" width="186" height="46" class="bmm js-chart-drawn" data-chart="spark-line" data-dataset="[[43,48,52,58,50,95,100]]" data-labels="['a', 'b','c','d','e','f','g']" style="width: 186px; height: 46px; display: block;"></canvas>
                    </div>
                </div>
            </div>

            <hr class="aav">

            <div class="dh">
                <div class="eq aax">
                    <div class="by aaj">
                        <h6 class="atf">
                            Countries
                        </h6>

                        <a class="mo od tc ra" href="#">
                            <span class="atg" style="width: 62.4%;"></span>
                            United States
                            <span class="bmn asd">62.4%</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span class="atg" style="width: 15.0%;"></span>
                            India
                            <span class="bmn asd">15.0%</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span class="atg" style="width: 5.0%;"></span>
                            United Kingdom
                            <span class="bmn asd">5.0%</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span class="atg" style="width: 5.0%;"></span>
                            Canada
                            <span class="bmn asd">5.0%</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span class="atg" style="width: 4.5%;"></span>
                            Russia
                            <span class="bmn asd">4.5%</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span class="atg" style="width: 2.3%;"></span>
                            Mexico
                            <span class="bmn asd">2.3%</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span class="atg" style="width: 1.7%;"></span>
                            Spain
                            <span class="bmn asd">1.7%</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span class="atg" style="width: 1.5%;"></span>
                            France
                            <span class="bmn asd">1.5%</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span class="atg" style="width: 1.4%;"></span>
                            South Africa
                            <span class="bmn asd">1.4%</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span class="atg" style="width: 1.2%;"></span>
                            Japan
                            <span class="bmn asd">1.2%</span>
                        </a>

                    </div>
                    <a href="#" class="ce ko acb">All countries</a>
                </div>
                <div class="eq aax">
                    <div class="by aaj">
                        <h6 class="atf">
                            Most visited pages
                        </h6>

                        <a class="mo od tc ra" href="#">
                            <span>/ (Logged out)</span>
                            <span class="bmo asd">3,929,481</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span>/ (Logged in)</span>
                            <span class="bmo asd">1,143,393</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span>/tour</span>
                            <span class="bmo asd">938,287</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span>/features/something</span>
                            <span class="bmo asd">749,393</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span>/features/another-thing</span>
                            <span class="bmo asd">695,912</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span>/users/username</span>
                            <span class="bmo asd">501,938</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span>/page-title</span>
                            <span class="bmo asd">392,842</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span>/some/page-slug</span>
                            <span class="bmo asd">298,183</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span>/another/directory/and/page-title</span>
                            <span class="bmo asd">193,129</span>
                        </a>

                        <a class="mo od tc ra" href="#">
                            <span>/one-more/page/directory/file-name</span>
                            <span class="bmo asd">93,382</span>
                        </a>

                    </div>
                    <a href="#" class="ce ko acb">View all pages</a>
                </div>
            </div>

            <div class="by aaj">
                <h6 class="atf">
                    Devices and resolutions
                </h6>

                <a class="mo od tc ra" href="#">
                    <span>Desktop (1920x1080)</span>
                    <span class="asd">3,929,481</span>
                </a>

                <a class="mo od tc ra" href="#">
                    <span>Desktop (1366x768)</span>
                    <span class="asd">1,143,393</span>
                </a>

                <a class="mo od tc ra" href="#">
                    <span>Desktop (1440x900)</span>
                    <span class="asd">938,287</span>
                </a>

                <a class="mo od tc ra" href="#">
                    <span>Desktop (1280x800)</span>
                    <span class="asd">749,393</span>
                </a>

                <a class="mo od tc ra" href="#">
                    <span>Tablet (1024x768)</span>
                    <span class="asd">695,912</span>
                </a>

                <a class="mo od tc ra" href="#">
                    <span>Tablet (768x1024)</span>
                    <span class="asd">501,938</span>
                </a>

                <a class="mo od tc ra" href="#">
                    <span>Phone (320x480)</span>
                    <span class="asd">392,842</span>
                </a>

                <a class="mo od tc ra" href="#">
                    <span>Phone (720x450)</span>
                    <span class="asd">298,183</span>
                </a>

                <a class="mo od tc ra" href="#">
                    <span>Desktop (2560x1080)</span>
                    <span class="asd">193,129</span>
                </a>

                <a class="mo od tc ra" href="#">
                    <span>Desktop (2560x1600)</span>
                    <span class="asd">93,382</span>
                </a>

            </div>
            <a href="#" class="ce ko acb">View all devices</a>

        </div>
    </div>
</div>

<div id="docsModal" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Example modal</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                <p>You're looking at an example modal in the dashboard theme.</p>
            </div>
            <div class="om">
                <button type="button" class="ce kh" data-dismiss="modal">Cool, got it!</button>
            </div>
        </div>
    </div>
</div>





<jsp:include page="pieDePagina.jsp" flush="true"/>