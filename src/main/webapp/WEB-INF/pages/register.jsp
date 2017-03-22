<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-注册</title>
<meta name="keywords" content="帮5买CPS联盟,帮5买,CPS,海淘,联盟,海淘联盟,B5M,Union,CPS Union">
<meta name="description" content="帮5买CPS联盟">
<link href="<%=basePath %>/css/plugins/bootstrapvalidator/bootstrapValidator.min.css" rel="stylesheet">
<script src="<%=basePath %>/js/plugins/bootstrapvalidator/bootstrapValidator.min.js"></script>
</head>

<body class="top-navigation">

	<div id="wrapper">
		<div id="page-wrapper" class="gray-bg">
			<div class="row border-bottom white-bg">
				<nav class="navbar navbar-static-top" role="navigation">
					<div class="navbar-header">
						<!-- <button aria-controls="navbar" aria-expanded="false"
							data-target="#navbar" data-toggle="collapse"
							class="navbar-toggle collapsed" type="button">
							<i class="fa fa-reorder"></i>
						</button> -->
						<a href="<%=basePath%>/cpsx/toLogin.do" class="navbar-brand"><span id="cps_union_title_span"></span></a>
					</div>
					<div class="navbar-collapse collapse" id="navbar">
						<ul class="nav navbar-nav">
							<!-- <li class="active">
                                <a aria-expanded="false" role="button" href="layouts.html">首页</a>
                            </li> -->
							<li class="dropdown"><a aria-expanded="false" role="button"
								href="<%=basePath%>/registration/toRegister"></a><!-- <span id="advertising_client_or_site_master_span"></span> --></li>
						</ul>
						<ul class="nav navbar-top-links navbar-right">
							<li><a href="<%=basePath%>/cpsx/toLogin.do"> <i
									class="fa fa-home"></i><span id="homepage_span"></span>
							</a></li>
						</ul>
					</div>
				</nav>
			</div>

			<div class="wrapper wrapper-content">
				<div class="container">
					<div class="row">
					<div class="col-lg-2"></div>
						<div class="col-lg-8 animated fadeInRight">
							<div class="ibox-content">
								<form class="form-horizontal m-t" id="signupForm" action="<%=basePath%>/registration/register" method="post">
									<div class="form-group">
										<label class="col-sm-3 control-label"><font style="color:red">*</font><span id="user_type_span"></span>：</label> <label
											class="checkbox-inline"> <input type="radio"
											name="roleId" id="" value="3" checked><span id="site_master_span"></span>
										</label> <label class="checkbox-inline"> <input type="radio"
											name="roleId" id="" value="4"><span id="advertising_client_span"></span>
										</label>
									</div>
								
									<div class="form-group">
										<label class="col-sm-3 control-label"><font style="color:red">*</font><span id="email_span"></span>：</label>
										<div class="col-sm-8">
											<input id="email" name="email" class="form-control"
												type="email">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><font style="color:red">*</font><span id="user_name_span"></span>：</label>
										<div class="col-sm-8">
											<input id="userName" name="userName" class="form-control"
												type="text">
										</div>
									</div>
									<input type="hidden" id="password" name="password">
									<div class="form-group">
										<label class="col-sm-3 control-label"><font style="color:red">*</font><span id="password_span"></span>：</label>
										<div class="col-sm-8">
											<input id="pass" name="pass" class="form-control"
												type="password">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><font style="color:red">*</font><span id="repassword_span"></span>：</label>
										<div class="col-sm-8">
											<input id="repassword" name="repassword" class="form-control"
												type="password">
										</div>
									</div>

									<div class="form-group">
										<label class="col-sm-3 control-label"><font style="color:red">*</font><span id="account_type_span"></span>：</label> <label
											class="checkbox-inline"> <input type="radio"
											name="accountType" id="accountType_1" value="1" checked><span id="company_span"></span>
										</label> <label class="checkbox-inline"> <input type="radio"
											name="accountType" id="accountType_2" value="2"><span id="personal_span"></span>
										</label>
									</div>

									<div class="form-group">
										<label class="col-sm-3 control-label"><font style="color:red">*</font><span id="real_name_span"></span>：</label>
										<div class="col-sm-8">
											<input id="realName" name="realName" class="form-control"
												type="text">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><font style="color:red">*</font><span id="mob_tel_span"></span>：</label>
										<div class="col-sm-8">
											<input id="mobTel" name="mobTel" class="form-control"
												type="text">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><span id="fix_tel_span"></span>：</label>
										<div class="col-sm-8">
											<input id="fixTel" name="fixTel" class="form-control"
												type="text">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><span id="qq_span"></span>：</label>
										<div class="col-sm-8">
											<input id="qq" name="qq" class="form-control" type="text">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><span id="address_span"></span>：</label>
										<div class="col-sm-8">
											<input id="address" name="address" class="form-control"
												type="text">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><span id="zip_code_span"></span>：</label>
										<div class="col-sm-8">
											<input id="zipCode" name="zipCode" class="form-control"
												type="text">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><span id="introduction_span"></span>：</label>
										<div class="col-sm-8">
											<input id="introduction" name="introduction"
												class="form-control" type="text">
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><font style="color:red">*</font><a data-toggle="modal" data-target="#agreementModal"><span id="agreement_span" style="text-decoration:underline;"></span></a>：</label>
										<div class="col-sm-8">
											<input type="checkbox" class="checkbox" id="agree"
												name="agree" checked>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-8 col-sm-offset-3">
											<button class="btn btn-success" type="submit"><span id="submit_span"></span></button>
											<!-- <a href="javascript:void(0);" class="btn btn-success m-b" onclick="submitForm();">
												<span id="submit_span"></span>
											</a>&nbsp;<span class="text-center text-danger text-large" id="msg"></span> -->
										</div>
									</div>
									<div class="modal inmodal fade" id="agreementModal" tabindex="-1"
										role="dialog" aria-hidden="true">
										<div class="modal-dialog modal-lg">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">
														<span aria-hidden="true">&times;</span><span
															class="sr-only">Close</span>
													</button>
													<h4 class="modal-title">帮5买用户注册协议</h4> 
												</div>
												<div class="modal-body" style="height:300px; overflow:auto">
													<p>
														<strong>欢迎使用帮5买网站！</strong>
														本协议系上海载和网络科技有限公司（包括其关联公司，以下简称“帮5买”）和帮5买用户（以下简称“用户”）订立的关于用户注册及使用帮5买服务权利义务的规范约定。帮5买基于本服务协议及在帮5买网站上公示的各类与帮5买服务相关的规则、政策、流程、声明、公告等（以下统称“本协议”）的条款和条件向用户提供服务。用户通过任何形式使用帮5买服务，包括但不限于访问、浏览或使用帮5买网站、注册为帮5买用户，即被认为同意和接受本协议所有条件和条款。如果您不同
														意本协议条款和条件，您可以选择不使用帮5买服务。您一旦使用了帮5买服务，即受本协议约束。

														请用户在访问和使用帮5买所提供的服务前，务必仔细阅读本协议所有说明条款。本协议构成用户与帮5买之间达成的有效协议，具有法律效力，接受“本协议”全部
														条款的约束，法律另有强制性规定或双方另有特别约定的除外。用户不能以未阅读“本协议”或对“本协议”有任何误解为由，主张“本协议”无效或要求撤销“本协议”。

														一、注册说明

														1、用户必须先行注册，取得帮5买账号、密码才能使用帮5买注册用户服务；用户同意提供及时、详尽、准确及真实的个人资料，不断更新注册资料，符合及时、详尽、准确的要求。所有原始键入的资料将引用为注册资料。
														2、该账号和密码由用户自行管理和保管，用户应对其账号进行的所有活动承担责任。用户若发现任何非法使用用户账号或存在安全漏洞的情况，请立即通知帮5买，情节严重的应及时向公安机关报案。
														3、用户同意，帮5买有权使用用户的注册信息、用户名、密码等信息，登陆进入用户的注册账户，进行证据保全，包括但不限于公证、见证等。
														4、如果用户提供的资料不准确、不真实、不合法有效，帮5
														买公司保留结束用户使用帮5买服务的权利。用户同意，用户提供的真实准确的个人资料作为认定用户与账号的关联性以及用户身份的唯一证据。用户在参与帮5买的同时，同意接受帮5买提供的各类信息服务。
														5、帮5买保留在中华人民共和国大陆地区法施行之法律允许的范围内独自决定拒绝服务、关闭用户账户、清除或编辑内容或取消订单的权利。

														二、用户管理

														1、用户承诺：用户在使用帮5买服务时实施的所有行为均遵守国家法律、法规和帮5买的相关规定以及各种社会公共利益或公共道德。
														2、用户不得利用帮5买从事侵害他人合法权益之行为，否则应承担所有相关法律责任，因此导致帮5买受损的，用户应承担赔偿责任。上述行为包括但不限于：
														1）违反法律法规或社会公共利益和公共道德的行为，侵害他人名誉权、隐私权、商业秘密、商标权、著作权、专利权等合法权益。
														2）侵犯其他任何第三方的知识产权或其他任何合法权益；
														3）教唆他人从事本条所禁止的行为，利用帮5买网站从事洗钱、窃取商业秘密、窃取个人信息等违法犯罪活动；
														4）任何可能对帮5买互联网或移动客户端服务正常运转产生不利影响的行为；
														5）进行与用户或交易对方的交易内容不符的交易，或不真实的交易。
														6）从事任何可能含有电脑病毒或是可能侵害本服务系统、资料之行为。
														7）对帮5买上任何数据作商业性利用，包括但不限于在未经帮5买事先书面批准的情况下，以复制、传播等方式使用在帮5买上展示的任何资料。
														8）其他帮5买认为不适当的行为或者法律、法规、规章等禁止的行为。
														帮5买有权对用户使用服务的情况进行实时审查和监督。如发现用户涉嫌在使用服务时违反任何上述规定的，帮5买有权单方面认定用户是否违反了任何上述规定，并采取改正、删除用户发布的内容、暂停或终止用户使用服务的权利等措施。
														3、用户恶意从帮5买获得不正当利益的行为均被禁止，一经发现，帮5买有权单方对恶意账号进行查封。
														4、严禁用户通过购买产品恶意取消订单等非法手段来牟取利益，一经发现，帮5买有权取消用户的资格，同时用户须承担由此给帮5买带来的所有经济损失。
														5、用户同意生成并储存于帮5买或合作伙伴服务器的与帮5买相关的数据作为解决争端时的有效判断依据，该项数据义务保存时间期限为两年（自数据产生起计算）。

														三、用户隐私信息政策

														1、对于用户在注册以及使用帮5买服务过程中向帮5买提供，或在使用帮5买服务过程中产生的归属于用户个人的资料以及信息，帮5买将遵循以下原则尊重并保护：
														1) 帮5买不会向任何人出售，出借您的个人信息，除非事先得到用户的许可。 2)
														帮5买亦不会许可任何第三方以任何手段收集、编辑、出售或者无偿传播您的个人信息。
														2、用户的个人信息将在下述情况下部分或全部被披露： 1) 经用户同意，向第三方披露； 2)
														根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露； 3)
														如果用户出现违反中国有关法律或者帮5买的服务协议或帮5买网站其它政策的情况，需要向第三方披露； 4)
														为提供用户所要求的产品和服务，而必须和第三方分享用户的个人信息； 5)
														其它帮5买根据法律或者自身或其关联公司政策以及本协议的约定认为合适的披露。 四、 规则

														1、本协议提供的服务或任何相关的软件安装均根据用户的需求来确认实施。因网络数据信息的巨大灵活变动性，帮5买不保障用户使用本服务和软件进行查询的所有商品信息均为有效，仅为提供参考，用户如应自行核实和确认，在任何条件下做出的选择都应当由用户自主做出，帮5买对用户的自主选择行为不承担任何法律后果，除非用户购买的商品是帮5买自营商品服务。
														2、考虑到用户下载软件和得到服务时的期望—享受商品比较信息或优惠帮助信息，本服务作为购物助手可能在用户浏览相关网站时自主提示商品信息或帮5买的服务信息，用户充分理解和同意这种行为。
														3、用户须对自己在参与帮5买服务过程中的行为承担法律责任。用户承担法律责任的形式包括但不限于：对被侵权者进行赔偿，以及在帮5买先行承担了因用户侵权及违约行为导致的行政处罚或侵权损害赔偿责任后，该责任用户应全额偿还帮5买为其行为所付出的所有费用。
														4、用户不得通过任何手段恶意获得帮钻，包括但不限于采用各种违规、作弊手段获得帮钻；同一用户以牟利、套现、获奖等目的注册多个帮5买账号；盗用其他用户帐号等。一经发现，帮5买有权采取一切必要的措施，包括但不限于取消用户获得的帮钻，暂停或查封帮5买帐号，取消因违规所获利益，保留通过法律手段追回因违规获得帮钻而给帮5买造成的直接或间接经济损失的权利。
														5、用户获得帮钻的前提条件是安装并使用帮5淘软件，并绑定唯一有效手机号码。
														6、对于秒杀、限时抢购等商品，小帮帮不一定能够100%帮购成功，
														若因商品差价过高或者缺货导致无法帮购，退款将根据您的支付方式原路返回。若客户下单并成功付款5日内不能成功帮购，则我公司原路返还已付价款，且从客户支付日起的第6日（包括第6日）起根据中国人民银行的同期活期利率支付利息。
														7、用户购买帮购商品时，需要同意超级帮钻退款形式方可享受下单，若用户主动申请退款，退款也将以超级帮钻形式返至其帮5买账户。
														100超级帮钻=1元RMB 超级帮钻可抵扣全网商品 超级帮钻不可提现
														8、单价1元及以下商品不支持帮购；单价8000元以上商品不支持帮购；虚拟商品不支持帮购。
														9、用户使用帮5买服务时，对同一家店铺同一天内超过5次使用帮购服务、与商家串通更改商品价格或运费价格或虚假发货，一经查实，我公司有权对此账号进行查封。
														10、 对于使用规则的更新客户应关注网站通知，本网不再也无法一一通知，敬请谅解。 五、协议更新及用户关注义务

														1、帮5买保留依其自主判断在将来的任何时间变更、修改、增加或删除本协议条款的权利。帮5买网站上公布的所有的各类与帮5买服务相关的规
														则、政策、流程、声明、公告等在修改后，均自动成为本协议的有效组成部分，与本协议具有同等法律效力。修改后的协议一旦被张贴在帮5买网站上即生效，并代
														替原来的协议。
														2、用户可随时登陆查阅最新协议；用户有义务不时关注并阅读最新版的协议及网站公告。如用户不同意更新后的协议，可以且应立即停止接受帮5买网站依据本协
														议提供的服务；如用户继续使用本网站提供的服务的，即视为同意更新后的协议。帮5买建议用户在使用帮5买网站之前阅读本协议及帮5买网站的公告。

														六、所有权、知识产权以及其他权利归属 1、用户一旦接受本协议，即表明该用户主动将其在任何时间段在帮5买网站
														发表的任何形式的信息内容（包括但不限于用户评价、各类话题文章等信息内容）的财产性权利等任何可转让的权利，如著作权财产权（包括并不限于：复制权、发
														行权、出租权、展览权、表演权、放映权、广播权、信息网络传播权、摄制权、改编权、翻译权、汇编权以及应当由著作权人享有的其他可转让权利），全部独家且
														不可撤销地转让给帮5买所有，用户同意帮5买有权就任何主体侵权而单独提起诉讼。
														2、除法律另有强制性规定外，未经帮5买明确的特别书面许可,任何单位或个人不得以任何方式非法地全部或部分复制、转载、引用、链接、抓取或以其他方式使用帮5买网站的信息内容，否则，帮5买有权追究其法律责任。
														3、帮5买网站所刊登的资料信息（诸如文字、图表、标识、按钮图标、图像、声音文件片段、数字下载、数据编辑和软件），均为帮5买或其他相关权利人所有，除非事先经帮5买或相关权利人的合法授权，任何人皆不得擅自以任何形式使用。
														4、任何单位或个人认为帮5买网页内容（包括不限于帮5买会员用户发布的商品/服务信息）可能涉嫌侵犯其信息网络传播权，应该及时向帮5买提出书面权利通
														知，并提供相关资质证明、权利归属证明及详细侵权情况证明。帮5买在收到上述法律文件后，经审核确认后，将会尽快移除相关涉嫌侵权的内容。具体参见《知识
														产权保护声明》
														5、如果本协议中任何一条被视为废止、无效或因任何理由不可执行，该第六条应视为可分的且并不影响其有效性和可执行性。

														七、责任限制

														1、在有合理必要时，帮5买可以调整服务优惠信息或措施，有权通过技术手段扩展应用服务和内容，无需再经过用户一一确认。用户有任何异议的，可以提出终止服务协议。帮5买经事先通知可完全终止提供帮5买服务，并且无需向用户承担任何责任。
														2、为了网站的正常运行，帮5买需要定期对网站进行停机维护或针对突发事件进行紧急停机维护；因上述情况而造成的帮5买正常服务暂时中断，用户应该予以理解，帮5买会尽力避免服务中断并将中断时间限制在最短时间内。
														3、如因不可抗力或其它帮5买网站无法控制的原因使帮5买网站销售系统崩溃或无法正常使用导致网上交易无法完成或丢失有关的信息、记录等，帮5买会合理地尽力协助处理善后事宜。
														4、用户明确同意，网站购物风险由用户自己承担。
														5、用户理解并接受下载或通过帮5买取得的任何信息资料取决于用户自己，并由其承担系统受损、资料丢失以及其它任何风险。
														6、在适用法律允许的最大范围内，帮5买不因用户使用帮5买服务，或在任何方面与此服务有关的，或以其它方式通过帮5买提供给用户的全部信息、内容、材
														料、商品（包括软件）和服务、或购买和使用产品引起的的任何损害而承担责任，包括但不限于直接的、意外的、非直接的、特殊的、或间接的或附带的惩罚性和结
														果性的损害赔偿或请求（包括但不限于因隐私泄漏、因未能履行包括诚信或合理谨慎在内的任何责任、因过失和因任何其他金钱上的损失或其他损失而造成的损害赔
														偿）。
														7、鉴于帮5买以非人工检索方式、根据用户键入的关键字自动生成到第三方网页的链接，除帮5买注明之服务条款外，其他一切因使用帮5买而可能遭致的意外、
														疏忽、侵权及其造成的损失（包括因下载被搜索链接到的第三方网站内容而感染电脑病毒），帮5买对其概不负责，亦不承担任何法律责任。
														8、帮5买聚合结果根据您键入的关键字自动搜索获得并生成，不代表帮5买赞成被搜索链接到的第三方网页上的内容或立场。
														9、用户应该对使用搜索引擎的结果自行承担风险。帮5买不做任何形式的保证：不保证搜索结果满足您的要求
														，不保证搜索服务不中断，不保证搜索结果的安全性、正确性、及时性、合法性。因网络状况、通讯线路、第三方网站等任何原因而导致用户不能正常使用帮5买，
														帮5买不承担任何法律责任。 10、帮5买义务为用户保存相关交易记录、服务记录等备查电子文档的期限为两年。 八、通知

														所有发给用户的通知都可通过电子邮件、常规的信件或在网站显著位置公告的方式进行传送。帮5买将通过上述方法之一将消息传递给用户，告知他们服务协议的修改、服务变更、或其它重要事情。同时，用户同意，帮5买可向用户发送电子邮件、带有营销性质的EDM以及商业性广告。
														以上如有问题可以联系客服电话：400-085-0505 九、法律管辖和适用

														1、本协议的订立、执行和解释及争议的解决适用中华人民共和国的法律。
														2、当本协议的任何内容与中华人民共和国法律相抵触时，应当以法律规定为准，同时相关条款将按法律规定进行修改或重新解释，而本协议其他部分的法律效力不变。
														3、如因本协议出现的任何纠纷，用户和帮5买一致同意将纠纷交由上海市浦东新区人民法院管辖。 十、其它声明

														1、帮5买网站所有者是指在政府部门依法许可或备案的帮5买网站经营主体。
														2、帮5买尊重用户的合法权利，本协议及本网站上发布的各类规则、声明等其他内容，均是为了更好的、更加便利的为用户和消费者提供服务。帮5买网站欢迎用户和社会各界提出意见和建议，帮5买将虚心接受并适时修改本协议及帮5买网站上的各类规则。
														3、帮5买不行使、未能及时行使或者未充分行使本条款或者按照法律规定所享有的权利，不应被视为放弃该权利，也不影响帮5买在将来行使该权利。
														4、本协议内容中以黑体、加粗、下划线、斜体等方式显著标识的条款，请用户着重阅读。
														5、如果本协议中任何一条被视为废止、无效或因任何理由不可执行，并不影响任何其余条款的有效性和可执行性。

														用户如对本协议有任何疑问，请发送邮件至帮5买会员顾问邮箱（mc@b5m.com）或法务邮箱（legal@b5m.com），或登陆帮5买FAQ(http://www.b5m.com)获取相关信息。

														帮5买知识产权保护声明

														除帮5买特别注明外，帮5买仅提供根据用户搜索指令，采用搜索引擎技术搜索互联网第三方所自动生成的搜索结果链接页面展示，最终作品内容由第三方提供，与帮5买无关。
														帮5买高度重视知识产权保护并遵守中国各项知识产权法律、法规和具有约束力的规范性文件，尊重著作权人的合法权益。根据我国法律的有关规定，帮5买遵循如
														下旨在保护权利人合法权益的措施和步骤，当权利人发现帮5买用户上传的内容或搜索结果生成的链接所指向的第三方内容侵犯其合法权益时，权利人应事先向帮5
														买发出「权利通知书」，帮5买将根据中国法律法规的有关规定采取措施移除相关内容或断开相关链接。
														为保证帮5买有效处理您发送的“权利通知”，请您确保权利通知应包括以下内容：
														1、具体的联络信息，包括权利人的姓名(名称)、通信地址、电话号码、身份证/护照复印件(自然人)、单位登记证明复印件；
														2、要求删除或断开链接的作品或文字名称及确切网络地址；
														3、构成侵权的初步证明材料，包括但不限于权利人对涉嫌侵权作品或内容拥有合法权利的权属证明文件、涉嫌侵权事实等；
														4、权利通知需由权利人或其合法授权人亲笔签名，若权利人为单位则需加盖单位公章。
														您应对权利通知内容的真实性负责。您应了解，若通知书的内容不真实，您将承担由此造成的全部法律责任。帮5买在收到符合条件的权利通知后，将根据中国法律
														法规及规范性文件采取措施立即删除相关涉嫌侵权内容，或者断开与涉嫌侵权作品或内容的链接，并将相应权利通知转送作品或内容提供者。

														反通知
														作品或内容提供者收到帮5买转送的权利通知后，认为其提供的作品或内容未侵犯他人权利的，可以书面形式向帮5买提供反通知，要求恢复被删除的作品或内容，或恢复被断开的链接。
														反通知应当包含下列内容：
														1、具体的联络信息，包括权利人的姓名(名称)、通信地址、电话号码、身份证/护照复印件(自然人)、单位登记证明复印件；
														2、要求恢复被删除或者被断开链接的作品或内容的准确名称和网络地址；
														3、不构成侵权的初步证明材料，包括但不限于对作品或内容享有合法权利的权属证明文件等；
														4、反通知需由权利人或其合法授权人亲笔签名，若为单位则需加盖单位公章。
														作品或内容提供者应对反通知书内容的真实性负责。若反通知的内容不真实，提供者将承担由此造成的全部法律责任。帮5买收到作品或内容提供者的反通知后，将
														立即恢复被删除的作品或内容，或者恢复被断开的作品或内容链接，同时将作品或内容提供者的反通知转送权利人。帮5买对恢复被删除作品或内容，或恢复者被断
														开作品或内容链接的行为不承担任何法律责任。权利人不得再通知帮5买删除该作品或内容，或者断开与该作品或内容的链接。

														权利通知及反通知应以书面方式发往邮箱：legal@b5m.com
														本《知识产权保护声明》作为《用户服务协议》的有效组成部分，与其具有同等法律效力。
													</p>
												</div>

												<div class="modal-footer">
													<button type="button" class="btn btn-primary" onclick="checkAgree();">同意并继续</button>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
						<div class="col-lg-2"></div>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- Mainly scripts -->
	<script type="text/javascript">
		window.onload = function() {
			switchLanguage(language_flag);

			if (language_flag == 0) {
				$('#signupForm')
						.bootstrapValidator(
								{
									message : 'This value is not valid',
									feedbackIcons : {
										valid : 'fa fa-check',
										invalid : 'fa fa-times',
										validating : 'fa fa-refresh'
									},
									fields : {
										userName : {
											message : 'The username is not valid',
											validators : {
												notEmpty : {
													message : 'The username is required and cannot be empty'
												},
												stringLength : {
													min : 5,
													max : 30,
													message : 'The username must be more than 5 and less than 30 characters long'
												}
											}
										},
										email : {
											validators : {
												notEmpty : {
													message : 'The email is required and cannot be empty'
												},
												emailAddress : {
													message : 'The input is not a valid email address'
												},
												callback: {     //提交到后台进行校验
								                    message: 'Email Address Existed!',        //提示信息
								                    callback: function(value, validator) {
								                        //用ajax提交到后台，进行校验。如果校验失败  return false; 校验成功 return true;
								                        var res = true;
								                        if (value.match(/^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/i)) {
								                        	$.ajax({
									            				url : "<%=basePath%>/registration/checkValidation.do",
									            				type : "POST",
									            				async: false,
									            				data : {
									            					email : value
									            				},
									            				success : function(data) {
									            	 				var msg0 = data["msg0"];
									            					if(msg0 != "Success") {
									            						res = false;
									            					}
									            				}
									            			});					  
								                        }
								                        return res;
								                    }
								                }
											}
										},
										pass : {
											validators : {
												notEmpty : {
													message : 'The password is required and cannot be empty'
												},
												stringLength : {
													min : 5,
													max : 18,
													message : 'The password must be more than 5 and less than 18 characters long'
												},
												identical : {
													field : 'repassword',
													message : 'The password and its confirm are not the same'
												},
												different : {
													field : 'userName',
													message : 'The password cannot be the same as username'
												}
											}
										},
										repassword : {
											validators : {
												notEmpty : {
													message : 'The confirm password is required and cannot be empty'
												},
												stringLength : {
													min : 5,
													max : 18,
													message : 'The confirm password must be more than 5 and less than 18 characters long'
												},
												identical : {
													field : 'pass',
													message : 'The password and its confirm are not the same'
												},
												different : {
													field : 'userName',
													message : 'The confirm password cannot be the same as username'
												}
											}
										},
										realName : {
											message : 'The contact name is not valid',
											validators : {
												notEmpty : {
													message : 'The contact name is required and cannot be empty'
												},
												stringLength : {
													min : 5,
													max : 30,
													message : 'The contact name must be more than 5 and less than 30 characters long'
												}
											}
										},
										mobTel : {
											message : 'The mobile phone is not valid',
											validators : {
												notEmpty : {
													message : 'The mobile phone is required and cannot be empty'
												},
												stringLength : {
													min : 8,
													max : 15,
													message : 'The mobile phone must be more than 8 and less than 15 characters long'
												},
												regexp : {
													regexp : /^[0-9]+$/,
													message : 'The mobile phone can only consist of numbers'
												}
											}
										},
										agree : {
											validators : {
												callback: {     //
								                    message: 'Agreement is not checked!',        //提示信息
								                    callback: function(value, validator) {
								                        //用ajax提交到后台，进行校验。如果校验失败  return false; 校验成功 return true;
								                        var res = $("#agree").prop("checked");
								                        return res;
								                    }
								                }
											}
										}
									}
								}) .on('success.field.fv', function(e, data){
									if(data.fv.getInvalidFields().length > 0) {
										//There is invalid Field
										data.fv.disableSubmitButtons(true);
									}
								})
								.on('success.form.bv', function(e, data) {
									//Prevent From Submission
									//e.printDefault();
									var $form = $(e.target);
									
									//You can get the form instance
									var fv = $form.data('formValidation');
									
									//Do whatever you want here...
									$("#password").val($.md5($.md5($("#pass").val()) + $.md5($("#email").val())));
									
								})
			}

			if (language_flag == 1) {
				$('#signupForm').bootstrapValidator({
					message : '该值无效',
					feedbackIcons : {
						valid : 'fa fa-check',
						invalid : 'fa fa-times',
						validating : 'fa fa-refresh'
					},
					fields : {
						userName : {
							message : '用户名无效',
							validators : {
								notEmpty : {
									message : '用户名不能为空'
								},
								stringLength : {
									min : 5,
									max : 30,
									message : '用户名必须在5~30个字符之间'
								}
							}
						},
						email : {
							validators : {
								notEmpty : {
									message : '邮箱不能为空'
								},
								emailAddress : {
									message : '不是一个有效的邮箱'
								},
								callback: {     //提交到后台进行校验
				                    message: '该邮箱已经被注册！',        //提示信息
				                    callback: function(value, validator) {
				                        //用ajax提交到后台，进行校验。如果校验失败  return false; 校验成功 return true;
				                        var res = true;
				                        if (value.match(/^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/i)) {
				                        	$.ajax({
					            				url : "<%=basePath%>/registration/checkValidation.do",
					            				type : "POST",
					            				async: false,
					            				data : {
					            					email : value
					            				},
					            				success : function(data) {
					            	 				var msg0 = data["msg0"];
					            					if(msg0 != "Success") {
					            						res = false;
					            					}
					            				}
					            			});					  
				                        }
				                        return res;
				                    }
				                }
							}
						},
						pass : {
							validators : {
								notEmpty : {
									message : '密码不能为空'
								},
								stringLength : {
									min : 5,
									max : 18,
									message : '密码长度必须在5~18之间'
								},
								identical : {
									field : 'repassword',
									message : '前后密码不一致'
								},
								different : {
									field : 'userName',
									message : '密码不能与用户名相同'
								}
							}
						},
						repassword : {
							validators : {
								notEmpty : {
									message : '确认密码不能为空'
								},
								stringLength : {
									min : 5,
									max : 18,
									message : '确认密码长度必须在5~18之间'
								},
								identical : {
									field : 'pass',
									message : '前后密码不一致'
								},
								different : {
									field : 'userName',
									message : '确认密码不能与用户名相同'
								}
							}
						},
						realName : {
							message : '联系人无效',
							validators : {
								notEmpty : {
									message : '联系人不能为空'
								},
								stringLength : {
									min : 5,
									max : 30,
									message : '联系人必须在5~30之间'
								}
							}
						},
						mobTel : {
							message : '手机号码无效',
							validators : {
								notEmpty : {
									message : '手机号码不能为空'
								},
								stringLength : {
									min : 8,
									max : 15,
									message : '手机号码必须在8-15个数字之间'
								},
								regexp : {
									regexp : /^[0-9]+$/,
									message : '手机号码必须为数字'
								}
							}
						},
						agree : {
							validators : {
								callback: {     //
				                    message: '同意条款未勾选！',        //提示信息
				                    callback: function(value, validator) {
				                        //用ajax提交到后台，进行校验。如果校验失败  return false; 校验成功 return true;
				                        var res = $("#agree").prop("checked");
				                        return res;
				                    }
				                }
							}
						}
					}//Fields End
				})
					.on('success.field.fv', function(e, data){
						if(data.fv.getInvalidFields().length > 0) {
							//There is invalid Field
							data.fv.disableSubmitButtons(true);
						}
					})
					.on('success.form.bv', function(e, data) {
						//Prevent From Submission
						//e.printDefault();
						var $form = $(e.target);
						
						//You can get the form instance
						var fv = $form.data('formValidation');
						
						//Do whatever you want here...
						$("#password").val($.md5($.md5($("#pass").val()) + $.md5($("#email").val())));
						
					})
			}
				
		}
		
		function checkAgree() {
			$("#agree").prop("checked", true);
			$("#agreementModal").modal("hide");
		}
	</script>

	<script src="<%=basePath %>/js/footer.js"></script>
</body>
</html>
