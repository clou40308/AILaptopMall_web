<%@page pageEncoding="UTF-8"%>
<!-- light_box.jsp start -->
	<!--遮蔽元件外圍元件 id="modalWindow"-->
	<div id="modalWindow">
		<!--訊息對話框元件 class="messageWindow"-->
		<div class="messageWindow">
			<!--關閉按鈕元件 class="closeBtn"-->
			<div class="closeBtn" onclick="closeHandler()">X</div>
			<div id="showResultDiv">
				Mickey has been through many design changes from 1928. In his first cartoon Plane Crazy, Mickey had no gloves or shoes and his eyes were large black ovals. He first wore gloves when he sat down to play piano in the Opry House and by 1939 in The Pointer Mickey was shown with a pupil.
			</div>
		</div>
	</div>	
	<script>
	$(".messageWindow").on("mouseenter",  doNotClose);
	
	$(".messageWindow").on("mouseleave",  doClose);
	
	function doNotClose(){
		console.log("enter");
		modalWindow.onclick=null;
	}
	
	function doClose(){
		console.log("leave");
		modalWindow.onclick=closeHandler;
	}
	
	function closeHandler(){
		//alert("close");
		$("#modalWindow").css("display", "none");		
	}
	function showHandler(result){
		//alert("show");
		$("#showResultDiv").html(result);
		$("#modalWindow").css("display", "flex");
	}
	closeHandler();
	</script>
	
	<style>
		#modalWindow {
			position: fixed;
			left: 0px;
			top: 0px;
			width: 100vw;
			height: 100vh;
			background: rgba(0, 0, 0, 0.6);
			display: flex; /*display: none;*/			
			align-items:center;
			justify-content:center;
			z-index: 3;
		}

		.messageWindow {
			position: relative;
			padding: 0px;
			width: 85%;
			min-width: 500px;
			max-width:1000px;
			background: white;
			border: 5px solid gray;		
		}

		.closeBtn {
			position: absolute;
			top: 10px;
			right: 10px;
			width: 16px;
			height: 16px;
			text-align: center;
			line-height: 16px;
			padding: 5px;
			background-color: rgba(240, 240, 240, 1);
			border-radius: 50%;
			cursor: pointer;
		}

/* 		.messageWindow img { */
/* 			width: 150px;margin: 10px;float: left; */
/* 		} */

		#showResultDiv {
			margin-top: 18px;
			text-align: justify;
		}

		#showBtn {
			position: fixed;
			top: 50px;
			right: 50px;
		}
	
	</style>