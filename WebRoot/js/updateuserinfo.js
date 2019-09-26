//这个js 文件用于判断用户修改信息时的输入是否合法

	/*$(document).ready(function(){
		
		
		//创建一个*
		$(".a1").each(function(){
			
			var star = $("<strong class='reda'>*</strong>");
			
			$(this).parent().append(star);

			});
			//end
			
	
		$("form :input").blur(function(){
			
			$(this).parent().find(".a2").remove();
			
			//判断		
			if ($(this).is("#username")){
				
				if (this.value=="" || this.value.length < 6){
					
					var span1 = $("<span class='a2 error'>用户名不得小于6位</span>");
					
					$(this).parent().append(span1);
					
					}else{
						
					var span1 = $("<span class='a2 righta'>正确</span>");
					
					$(this).parent().append(span1);				
				}

			}
			//end	
			
	
			//判断		
			if ($(this).is("#truename")){
				
				if (this.value==""){
					
					var span1 = $("<span class='a2 error'>真实姓名不得为空</span>");
					
					$(this).parent().append(span1);
					
					}else{
						
					var span1 = $("<span class='a2 righta'>正确</span>");
					
					$(this).parent().append(span1);				
				}

			}
			//end
			
			//判断		
			if ($(this).is("#email")){
				
				if (this.value=="" || ( this.value!="" && !/.+@.+\.[a-zA-Z]{2,4}$/.test(this.value) )){
					
					var span1 = $("<span class='a2 error'>邮件的格式不正确</span>");
					
					$(this).parent().append(span1);
					
					}else{
						
					var span1 = $("<span class='a2 righta'>正确</span>");
					
					$(this).parent().append(span1);				
				}

			}
			//end	
			
			//判断		
			if ($(this).is("#phone")){
				
				if (this.value=="" || isNaN($(this).val()) || this.value.length != 11 ){
					
					var span1 = $("<span class='a2 error'>手机号不得为空，必须是11位数字</span>");
					
					$(this).parent().append(span1);
					
					}else{
						
					var span1 = $("<span class='a2 righta'>正确</span>");
					
					$(this).parent().append(span1);				
				}

			}
			//end
			
			//判断		
			if ($(this).is("#address")){
				
				if (this.value==""){
					
					var span1 = $("<span class='a2 error'>联系地址不得为空</span>");
					
					$(this).parent().append(span1);
					
					}else{
						
					var span1 = $("<span class='a2 righta'>正确</span>");
					
					$(this).parent().append(span1);				
				}

			}
			//end
			
			//判断		
			if ($(this).is("#postcode")){
				
				if (this.value=="" || (this.value!="" && !/^\d{6}$/.test(this.value))){
					
					var span1 = $("<span class='a2 error'>邮编格式不正确</span>");
					
					$(this).parent().append(span1);
					
					}else{
						
					var span1 = $("<span class='a2 righta'>正确</span>");
					
					$(this).parent().append(span1);				
				}

			}
			//end

	});	
	//blur  end
		
		
		
		//提交
		$("#send").click(function(){
			
			$("form :input").trigger("blur");
			
			var span3 = $(".error").length; 
			
			if (span3){
				
				return false;
				
				}
			
			alert("注册成功");	
	
		});
	//end
	
	
	
		//重置
		$("#res").click(function(){
			
			$(".a2").remove();

			});
			//end
	
		
	});	*/
	
	//使用ajax和服务器异步交互，验证用户名是否唯一
	//一号线:创建ajax引擎
		function getXmlHttpObject(){
		
			var xmlHttpRequest;
			//不同的浏览器获取对象xmlhttprequest的方法不一样
			if(window.ActiveXobject){
				//如果是IE浏览器
				xmlHttpRequust = new ActiveXobject("Microsoft.XMLHTTP");
			}else{
				//其他浏览器
				xmlHttpRequest = new XMLHttpRequest();
			}
			return xmlHttpRequest;
		}
	
		var  myXmlHttpRequest="";  	//设置为全局变量
		
		//二号线:发送http请求
		function checkName(){		//验证用户名是否存在
			myXmlHttpRequest = getXmlHttpObject();
			//window.alert("创建ok");
			//var val=document.getElementById("username").value;
			//window.alert(val);
			//怎么判断创建ok
			if(myXmlHttpRequest){
				//通过myXmlHttpRequest对象发送请求道服务器的某个页面
				//第一个参数表示请求的方式,"get" / "post"
				//第二个参数指定url,对哪个页面发出ajax 请求(本质仍然是http请求)
				//第三个参数表示 true 表示使用异步机制，false表示不使用异步机制
				window.alert("创建ok");
				var val=document.getElementById("username").value;
				window.alert("val="+val);
				var url="/SunDance/CheckNameServlet?username="+val;
				//打开请求
				myXmlHttpRequest.open("get",url,true);
				//指定回调函数 chuli 是函数名
				myXmlHttpRequest.onreadystatechange=chuli;
				//真的发送请求，如果是get请求则填入null即可
				//入股是post请求，则填入实际的数据
				myXmlHttpRequest.send(null);
			}
			
		}
		
		//三号线:AjaxClServlet 处理
		//四号线:回调函数
		function chuli(){
			//window.alert("处理函数被调回"+myXmlHttpRequest.readyState);
			//取出从AjaxClServlet返回的数据
			if(myXmlHttpRequest.readyState==4){
			//取出值，根据返回信息的格式定
			window.alert("服务器返回"+myXmlHttpRequest.responseText);
			document.getElementById("myres").innerText=myXmlHttpRequest.responseText;
			}
		}
	