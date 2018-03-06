<%--
  Created by IntelliJ IDEA.
  User: chen
  Date: 18-3-3
  Time: 下午2:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的订单</title>
</head>
<body>
    <div class="bought-div">
        <div class="bought-orderType">
            <div class="select-orderType"><a >所有订单</a></div>
            <div><a>待付款</a></div>
            <div><a>待发货</a></div>
            <div><a>待收货</a></div>
            <div><a class="noRight-a">待评价</a></div>
            <div class="orderTypeLastOne">
                <a class="noRight-a"></a>
            </div>
        </div>
        <div style="clear:both"></div>
        <div class="orderList-title">
            <table class="orderList-title-table">
                <tr>
                    <td>宝贝</td>
                    <td width="100px">单价</td>
                    <td width="100px">数量</td>
                    <td width="120px">实付款</td>
                    <td width="100px">交易操作</td>
                </tr>
            </table>
        </div>
        <div class="orderList-item">
            <c:forEach items="${orders}" var="o">
                <table class="orderList-item-table">
                    <tr class="orderList-item-tr">
                        <!-- 此处显示订单号码 以及一些功能图标 -->
                        <td colspan="2">
                            <b><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b>
                            <span>订单号: ${o.orderCode}</span>
                        </td>
                        <td  colspan="2"><img width="13px" src="img/site/orderItemTmall.png">天猫商场</td>
                        <td colspan="1">
                            <a class="wangwanglink" href="#nowhere">
                                <div class="orderItemWangWangGif"></div>
                            </a>
                        </td>
                        <td class="orderItem-delete-td" colspan="2">
                            <a class="deleteOrderLink" oid="${o.id}" href="#nowhere">
                                <span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
                            </a>
                        </td>
                    </tr>

                    <c:forEach items="${o.orderItems}" var="oi" varStatus="st">
                        <!-- 遍历Order中的OrderItems属性, 显示图片,名称,价格等-->
                        <tr class="orderItemProductInfo-tr">
                            <td class="orderItemProductInfo-td">
                                <img width="80" height="80" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg">
                            </td>
                            <td class="orderItemProductInfo-td">
                                <div class="orderListItemProductLinkOutDiv">
                                    <a href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
                                    <div class="orderListItemProductLinkInnerDiv">
                                        <img src="img/site/creditcard.png" title="支持信用卡支付">
                                        <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                        <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                                    </div>
                                </div>
                            </td>
                            <td  class="orderItemProductInfo-td" width="100px">
                                <div class="orderListItemProductOriginalPrice">￥<fmt:formatNumber type="number" value="${oi.product.originalPrice}" minFractionDigits="2"/></div>
                                <div class="orderListItemProductPrice">￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/></div>
                            </td>
                            <c:if test="${st.count==1}">
                                <td valign="top" rowspan="${fn:length(o.orderItems)}" class="orderListItemNumber-td orderItemOrderInfo-td" width="100px">
                                    <span class="orderListItemNumber">${o.total}</span>
                                </td>
                                <td valign="top" rowspan="${fn:length(o.orderItems)}" width="120px" class="orderListItemProductRealPrice-td orderItemOrderInfo-td">
                                    <div class="orderListItemProductRealPrice">￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${o.total}"/></div>
                                    <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                                </td>
                                <td valign="top" rowspan="${fn:length(o.orderItems)}"
                                    class="orderListItemButton-td orderItemOrderInfo-td" width="100px">
                                    <c:if test="${o.status=='waitConfirm' }">
                                        <a href="foreconfirmPay?oid=${o.id}">
                                            <button class="orderListItemConfirm">确认收货</button>
                                        </a>
                                    </c:if>
                                    <c:if test="${o.status=='waitPay' }">
                                        <a href="alipay?oid=${o.id}&total=${o.total}">
                                            <button class="orderListItemConfirm">付款</button>
                                        </a>
                                    </c:if>
                                    <c:if test="${o.status=='waitDelivery' }">
                                        <span>待发货</span>
                                        <button class="btn btn-info">催卖家发货</button>
                                    </c:if>
                                    <c:if test="${o.status=='waitReview' }">
                                        <a href="forereview?oid=${o.id}">
                                            <button  class="orderListItemReview">评价</button>
                                        </a>
                                    </c:if>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </table>
            </c:forEach>
        </div>
    </div>
<script>
    $(function () {
        $("a.deleteOrderLink").click(function () {
            //Get oid
            var oid = $(this).attr("oid");
            if(confirm("确认删除订单?")){
                $.ajax({
                    url:"deleteOrder",
                    type:"post",
                    data:{
                        oid:oid
                    },
                    success:function (result) {
                        if(result === "success")
                            location.reload();
                    }
            });
            }
        });
    });
</script>
</body>
</html>