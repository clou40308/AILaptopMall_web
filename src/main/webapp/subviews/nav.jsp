<%@page pageEncoding="UTF-8" %>
 	<!-- nav.jsp start -->
    <nav>
        <div class="navigation">
            <div class="menu">
            	<a href="<%= request.getContextPath() %>/products_list.jsp?">
            		<div class="menuList">全部</div>
            	</a>
            </div>
            <div class="menu">
            	<a href="<%= request.getContextPath() %>/products_list.jsp?latest=">
                	<div class="menuList">新品</div>
                </a>
            </div>
            <div class="menu">
	             <a href="<%= request.getContextPath() %>/products_list.jsp?maker=LENOVO">
	                <div class="menuList">LENOVO</div>
	             </a>
            </div>
            <div class="menu">
           		 <a href="<%= request.getContextPath() %>/products_list.jsp?maker=ACER">
                	<div class="menuList">ACER</div>
                 </a>
            </div>
            <div class="menu">
            	<a href="<%= request.getContextPath() %>/products_list.jsp?maker=ASUS">
                	<div class="menuList">ASUS</div>
                </a>
            </div>
            <div class="menu">
            	<a href="<%= request.getContextPath() %>/products_list.jsp?maker=HP">
                	<div class="menuList">HP</div>
                </a>
            </div>
            <div class="menu">
            	<a href="<%= request.getContextPath() %>/products_list.jsp?maker=DELL">
                	<div class="menuList">DELL</div>
                </a>
            </div>
            <div class="menu">
            	<a href="<%= request.getContextPath() %>/products_list.jsp?maker=MSI">
                	<div class="menuList">MSI</div>
                </a>
            </div>
            <div class="menu">
            	<a href="<%= request.getContextPath() %>/products_list.jsp?maker=Microsoft">
                	<div class="menuList">Microsoft</div>
                </a>
            </div>
            <div class="menu">
            	<a href="<%= request.getContextPath() %>/products_list.jsp?maker=LG">
                	<div class="menuList">LG</div>
                </a>
            </div>
        </div>
    </nav>
    <!-- nav.jsp end -->