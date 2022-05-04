/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : nblog

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 02/05/2022 22:53:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for about
-- ----------------------------
DROP TABLE IF EXISTS `about`;
CREATE TABLE `about`  (
  `id` bigint NOT NULL,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name_zh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of about
-- ----------------------------
INSERT INTO `about` VALUES (1, 'title', '标题', '关于帅气的 Alan');
INSERT INTO `about` VALUES (2, 'musicId', '网易云歌曲ID', '423015580');
INSERT INTO `about` VALUES (3, 'content', '正文Markdown', '');
INSERT INTO `about` VALUES (4, 'commentEnabled', '评论开关', 'true');

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章标题',
  `first_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章首图，用于随机文章展示',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章正文',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述',
  `is_published` bit(1) NOT NULL COMMENT '公开或私密',
  `is_recommend` bit(1) NOT NULL COMMENT '推荐开关',
  `is_appreciation` bit(1) NOT NULL COMMENT '赞赏开关',
  `is_comment_enabled` bit(1) NOT NULL COMMENT '评论开关',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `views` int NOT NULL COMMENT '浏览次数',
  `words` int NOT NULL COMMENT '文章字数',
  `read_time` int NOT NULL COMMENT '阅读时长(分钟)',
  `category_id` bigint NOT NULL COMMENT '文章分类',
  `is_top` bit(1) NOT NULL COMMENT '是否置顶',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码保护',
  `user_id` bigint NULL DEFAULT NULL COMMENT '文章作者',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_id`(`category_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag`  (
  `blog_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for city_visitor
-- ----------------------------
DROP TABLE IF EXISTS `city_visitor`;
CREATE TABLE `city_visitor`  (
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '城市名称',
  `uv` int NOT NULL COMMENT '独立访客数量',
  PRIMARY KEY (`city`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论内容',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像(图片路径)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '评论时间',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论者ip地址',
  `is_published` bit(1) NOT NULL COMMENT '公开或回收站',
  `is_admin_comment` bit(1) NOT NULL COMMENT '博主回复',
  `page` int NOT NULL COMMENT '0普通文章，1关于我页面，2友链页面',
  `is_notice` bit(1) NOT NULL COMMENT '接收邮件提醒',
  `blog_id` bigint NULL DEFAULT NULL COMMENT '所属的文章',
  `parent_comment_id` bigint NOT NULL COMMENT '父评论id，-1为根评论',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个人网站',
  `qq` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '如果评论昵称为QQ号，则将昵称和头像置为QQ昵称和QQ头像，并将此字段置为QQ号备份',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for exception_log
-- ----------------------------
DROP TABLE IF EXISTS `exception_log`;
CREATE TABLE `exception_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常信息',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exception_log
-- ----------------------------
INSERT INTO `exception_log` VALUES (1, '/admin/site-setting/get-by-name', 'GET', '{\"name\":\"qiniu\"}', '', 'org.springframework.jdbc.BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'qiniu\'\' at line 1\r\n### The error may exist in file [G:\\NBlog\\blog-api\\target\\classes\\mapper\\SiteSettingMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select * from site_setting where name_en ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'qiniu\'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'qiniu\'\' at line 1\r\n	at org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator.doTranslate(SQLErrorCodeSQLExceptionTranslator.java:235)\r\n	at org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator.translate(AbstractFallbackSQLExceptionTranslator.java:72)\r\n	at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:88)\r\n	at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:440)\r\n	at com.sun.proxy.$Proxy87.selectList(Unknown Source)\r\n	at org.mybatis.spring.SqlSessionTemplate.selectList(SqlSessionTemplate.java:223)\r\n	at org.apache.ibatis.binding.MapperMethod.executeForMany(MapperMethod.java:147)\r\n	at org.apache.ibatis.binding.MapperMethod.execute(MapperMethod.java:80)\r\n	at org.apache.ibatis.binding.MapperProxy$PlainMethodInvoker.invoke(MapperProxy.java:152)\r\n	at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:85)\r\n	at com.sun.proxy.$Proxy130.getByName(Unknown Source)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:344)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:198)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.dao.support.PersistenceExceptionTranslationInterceptor.invoke(PersistenceExceptionTranslationInterceptor.java:139)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.JdkDynamicAopProxy.invoke(JdkDynamicAopProxy.java:212)\r\n	at com.sun.proxy.$Proxy131.getByName(Unknown Source)\r\n	at top.naccl.service.impl.SiteSettingServiceImpl.getSiteInfo(SiteSettingServiceImpl.java:171)\r\n	at top.naccl.service.impl.SiteSettingServiceImpl$$FastClassBySpringCGLIB$$883ee53.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:687)\r\n	at top.naccl.service.impl.SiteSettingServiceImpl$$EnhancerBySpringCGLIB$$a425fb9b.getSiteInfo(<generated>)\r\n	at top.naccl.controller.admin.SiteSettingAdminController.getSettingByName(SiteSettingAdminController.java:63)\r\n	at top.naccl.controller.admin.SiteSettingAdminController$$FastClassBySpringCGLIB$$59864ce5.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at top.naccl.controller.admin.SiteSettingAdminController$$EnhancerBySpringCGLIB$$fdfbc0a5.getSettingByName(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:879)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:793)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:898)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:634)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at top.naccl.config.JwtFilter.doFilter(JwtFilter.java:57)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter.doFilter(AbstractAuthenticationProcessingFilter.java:200)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:373)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\nCaused by: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'qiniu\'\' at line 1\r\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:120)\r\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:97)\r\n	at com.mysql.cj.jdbc.exceptions.SQLExceptionsMapping.translateException(SQLExceptionsMapping.java:122)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeInternal(ClientPreparedStatement.java:953)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.execute(ClientPreparedStatement.java:370)\r\n	at com.zaxxer.hikari.pool.ProxyPreparedStatement.execute(ProxyPreparedStatement.java:44)\r\n	at com.zaxxer.hikari.pool.HikariProxyPreparedStatement.execute(HikariProxyPreparedStatement.java)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.apache.ibatis.logging.jdbc.PreparedStatementLogger.invoke(PreparedStatementLogger.java:59)\r\n	at com.sun.proxy.$Proxy122.execute(Unknown Source)\r\n	at org.apache.ibatis.executor.statement.PreparedStatementHandler.query(PreparedStatementHandler.java:64)\r\n	at org.apache.ibatis.executor.statement.RoutingStatementHandler.query(RoutingStatementHandler.java:79)\r\n	at org.apache.ibatis.executor.SimpleExecutor.doQuery(SimpleExecutor.java:63)\r\n	at org.apache.ibatis.executor.BaseExecutor.queryFromDatabase(BaseExecutor.java:325)\r\n	at org.apache.ibatis.executor.BaseExecutor.query(BaseExecutor.java:156)\r\n	at org.apache.ibatis.executor.CachingExecutor.query(CachingExecutor.java:109)\r\n	at com.github.pagehelper.PageInterceptor.intercept(PageInterceptor.java:108)\r\n	at org.apache.ibatis.plugin.Plugin.invoke(Plugin.java:61)\r\n	at com.sun.proxy.$Proxy166.query(Unknown Source)\r\n	at org.apache.ibatis.session.defaults.DefaultSqlSession.selectList(DefaultSqlSession.java:147)\r\n	at org.apache.ibatis.session.defaults.DefaultSqlSession.selectList(DefaultSqlSession.java:140)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:426)\r\n	... 125 more\r\n', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', '2022-04-24 21:37:28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `exception_log` VALUES (2, '/admin/site-setting/get-by-name', 'GET', '{\"name\":\"qiniu\"}', '', 'org.springframework.jdbc.BadSqlGrammarException: \r\n### Error querying database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'qiniu\'\' at line 1\r\n### The error may exist in file [G:\\NBlog\\blog-api\\target\\classes\\mapper\\SiteSettingMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: select * from site_setting where name_en ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'qiniu\'\' at line 1\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'qiniu\'\' at line 1\r\n	at org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator.doTranslate(SQLErrorCodeSQLExceptionTranslator.java:235)\r\n	at org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator.translate(AbstractFallbackSQLExceptionTranslator.java:72)\r\n	at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:88)\r\n	at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:440)\r\n	at com.sun.proxy.$Proxy87.selectList(Unknown Source)\r\n	at org.mybatis.spring.SqlSessionTemplate.selectList(SqlSessionTemplate.java:223)\r\n	at org.apache.ibatis.binding.MapperMethod.executeForMany(MapperMethod.java:147)\r\n	at org.apache.ibatis.binding.MapperMethod.execute(MapperMethod.java:80)\r\n	at org.apache.ibatis.binding.MapperProxy$PlainMethodInvoker.invoke(MapperProxy.java:152)\r\n	at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:85)\r\n	at com.sun.proxy.$Proxy130.getByName(Unknown Source)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:344)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:198)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.dao.support.PersistenceExceptionTranslationInterceptor.invoke(PersistenceExceptionTranslationInterceptor.java:139)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.JdkDynamicAopProxy.invoke(JdkDynamicAopProxy.java:212)\r\n	at com.sun.proxy.$Proxy131.getByName(Unknown Source)\r\n	at top.naccl.service.impl.SiteSettingServiceImpl.getSiteInfo(SiteSettingServiceImpl.java:171)\r\n	at top.naccl.service.impl.SiteSettingServiceImpl$$FastClassBySpringCGLIB$$883ee53.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:687)\r\n	at top.naccl.service.impl.SiteSettingServiceImpl$$EnhancerBySpringCGLIB$$a425fb9b.getSiteInfo(<generated>)\r\n	at top.naccl.controller.admin.SiteSettingAdminController.getSettingByName(SiteSettingAdminController.java:63)\r\n	at top.naccl.controller.admin.SiteSettingAdminController$$FastClassBySpringCGLIB$$59864ce5.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:771)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.aspectj.AspectJAfterThrowingAdvice.invoke(AspectJAfterThrowingAdvice.java:62)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:95)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:691)\r\n	at top.naccl.controller.admin.SiteSettingAdminController$$EnhancerBySpringCGLIB$$fdfbc0a5.getSettingByName(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:105)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:879)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:793)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)\r\n	at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:898)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:634)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:126)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:90)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:118)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:158)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at top.naccl.config.JwtFilter.doFilter(JwtFilter.java:57)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter.doFilter(AbstractAuthenticationProcessingFilter.java:200)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doHeadersAfter(HeaderWriterFilter.java:92)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:77)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:358)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:271)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:202)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:541)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:373)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:65)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1590)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:748)\r\nCaused by: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'\'qiniu\'\' at line 1\r\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:120)\r\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:97)\r\n	at com.mysql.cj.jdbc.exceptions.SQLExceptionsMapping.translateException(SQLExceptionsMapping.java:122)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeInternal(ClientPreparedStatement.java:953)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.execute(ClientPreparedStatement.java:370)\r\n	at com.zaxxer.hikari.pool.ProxyPreparedStatement.execute(ProxyPreparedStatement.java:44)\r\n	at com.zaxxer.hikari.pool.HikariProxyPreparedStatement.execute(HikariProxyPreparedStatement.java)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.apache.ibatis.logging.jdbc.PreparedStatementLogger.invoke(PreparedStatementLogger.java:59)\r\n	at com.sun.proxy.$Proxy122.execute(Unknown Source)\r\n	at org.apache.ibatis.executor.statement.PreparedStatementHandler.query(PreparedStatementHandler.java:64)\r\n	at org.apache.ibatis.executor.statement.RoutingStatementHandler.query(RoutingStatementHandler.java:79)\r\n	at org.apache.ibatis.executor.SimpleExecutor.doQuery(SimpleExecutor.java:63)\r\n	at org.apache.ibatis.executor.BaseExecutor.queryFromDatabase(BaseExecutor.java:325)\r\n	at org.apache.ibatis.executor.BaseExecutor.query(BaseExecutor.java:156)\r\n	at org.apache.ibatis.executor.CachingExecutor.query(CachingExecutor.java:109)\r\n	at com.github.pagehelper.PageInterceptor.intercept(PageInterceptor.java:108)\r\n	at org.apache.ibatis.plugin.Plugin.invoke(Plugin.java:61)\r\n	at com.sun.proxy.$Proxy166.query(Unknown Source)\r\n	at org.apache.ibatis.session.defaults.DefaultSqlSession.selectList(DefaultSqlSession.java:147)\r\n	at org.apache.ibatis.session.defaults.DefaultSqlSession.selectList(DefaultSqlSession.java:140)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:426)\r\n	... 125 more\r\n', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', '2022-04-24 21:37:46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '站点',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像',
  `is_published` bit(1) NOT NULL COMMENT '公开或隐藏',
  `views` int NOT NULL COMMENT '点击次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名称',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `status` bit(1) NULL DEFAULT NULL COMMENT '登录状态',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `create_time` datetime NOT NULL COMMENT '登录时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES (1, 'Admin', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 99.0.4844.51', b'1', '登录成功', '2022-03-13 16:46:44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36');
INSERT INTO `login_log` VALUES (2, 'Admin', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', b'1', '登录成功', '2022-04-22 01:20:06', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `login_log` VALUES (3, 'Admin', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', b'1', '登录成功', '2022-04-25 19:32:49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `login_log` VALUES (4, 'Admin', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', b'1', '登录成功', '2022-04-25 19:32:49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `login_log` VALUES (5, 'Admin', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', b'1', '登录成功', '2022-04-29 21:50:19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');

-- ----------------------------
-- Table structure for moment
-- ----------------------------
DROP TABLE IF EXISTS `moment`;
CREATE TABLE `moment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '动态内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `likes` int NULL DEFAULT NULL COMMENT '点赞数量',
  `is_published` bit(1) NOT NULL COMMENT '是否公开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作者用户名',
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `times` int NOT NULL COMMENT '请求耗时（毫秒）',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES (1, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":1,\"nameEn\":\"blogName\",\"nameZh\":\"博客名称\",\"value\":\"Naccl\'s Blog\",\"type\":1},{\"id\":2,\"nameEn\":\"webTitleSuffix\",\"nameZh\":\"网页标题后缀\",\"value\":\" - Naccl\'s Blog\",\"type\":1},{\"id\":3,\"nameEn\":\"footerImgTitle\",\"nameZh\":\"页脚图片标题\",\"value\":\"手机看本站\",\"type\":1},{\"id\":4,\"nameEn\":\"footerImgUrl\",\"nameZh\":\"页脚图片路径\",\"value\":\"\",\"type\":1},{\"id\":5,\"nameEn\":\"copyright\",\"nameZh\":\"Copyright\",\"value\":\"{\\\"title\\\":\\\"Copyright © 2019 - 2022\\\",\\\"siteName\\\":\\\"NACCL\'S BLOG\\\"}\",\"type\":1},{\"id\":6,\"nameEn\":\"beian\",\"nameZh\":\"ICP备案号\",\"value\":\"\",\"type\":1},{\"id\":7,\"nameEn\":\"reward\",\"nameZh\":\"赞赏码\",\"value\":\"\",\"type\":1},{\"id\":8,\"nameEn\":\"commentAdminFlag\",\"nameZh\":\"博主评论标识\",\"value\":\"咕咕\",\"type\":1},{\"id\":9,\"nameEn\":\"avatar\",\"nameZh\":\"头像\",\"value\":\"/img/avatar.jpg\",\"type\":2},{\"id\":10,\"nameEn\":\"name\",\"nameZh\":\"昵称\",\"value\":\"Naccl\",\"type\":2},{\"id\":11,\"nameEn\":\"rollText\",\"nameZh\":\"滚动个签\",\"value\":\"\\\"云鹤当归天，天不迎我妙木仙；\\\",\\\"游龙当归海，海不迎我自来也。\\\"\",\"type\":2},{\"id\":12,\"nameEn\":\"github\",\"nameZh\":\"GitHub\",\"value\":\"https://github.com/Naccl\",\"type\":2},{\"id\":13,\"nameEn\":\"telegram\",\"nameZh\":\"Telegram\",\"value\":\"https://t.me/NacclOfficial\",\"type\":2},{\"id\":14,\"nameEn\":\"qq\",\"nameZh\":\"QQ\",\"value\":\"http://sighttp.qq.com/authd?IDKEY=\",\"type\":2},{\"id\":15,\"nameEn\":\"bilibili\",\"nameZh\":\"bilibili\",\"value\":\"https://space.bilibili.com/\",\"type\":2},{\"id\":16,\"nameEn\":\"netease\",\"nameZh\":\"网易云音乐\",\"value\":\"https://music.163.com/#/user/home?id=\",\"type\":2},{\"id\":17,\"nameEn\":\"email\",\"nameZh\":\"email\",\"value\":\"mailto:you@example.com\",\"type\":2},{\"id\":18,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢的动漫 📺\\\",\\\"content\\\":\\\"异度侵入、春物语、NO GAME NO LIFE、实力至上主义的教室、辉夜大小姐、青春猪头少年不会梦到兔女郎学姐、路人女主、Re0、魔禁、超炮、俺妹、在下坂本、散华礼弥、OVERLORD、慎勇、人渣的本愿、白色相簿2、死亡笔记、DARLING in the FRANXX、鬼灭之刃\\\"}\",\"type\":2},{\"id\":19,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢我的女孩子们 🤤\\\",\\\"content\\\":\\\"芙兰达、土间埋、食蜂操祈、佐天泪爷、樱岛麻衣、桐崎千棘、02、亚丝娜、高坂桐乃、五更琉璃、安乐冈花火、一色彩羽、英梨梨、珈百璃、时崎狂三、可儿那由多、和泉纱雾、早坂爱\\\"}\",\"type\":2},{\"id\":20,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢玩的游戏 ?', '更新站点配置信息', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 884, '2022-04-24 19:59:10', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (2, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"nameEn\":\"qiniu\",\"nameZh\":\"七牛云配置\",\"value\":\"{\\\"id\\\":\\\"\\\",\\\"region\\\":\\\"d\\\",\\\"AK\\\":\\\"\\\",\\\"SK\\\":\\\"\\\",\\\"doMain\\\":\\\"d\\\",\\\"ak\\\":\\\"d\\\",\\\"sk\\\":\\\"d\\\"}\",\"type\":4}],\"deleteIds\":[]}}', '更新站点配置信息', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 513, '2022-04-24 22:02:41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (3, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":32,\"nameEn\":\"qiniu\",\"nameZh\":\"七牛云配置\",\"value\":\"{\\\"id\\\":\\\"\\\",\\\"region\\\":\\\"dggg\\\",\\\"AK\\\":\\\"\\\",\\\"SK\\\":\\\"\\\",\\\"doMain\\\":\\\"url\\\",\\\"ak\\\":\\\"ak\\\",\\\"sk\\\":\\\"sk\\\"}\",\"type\":4}],\"deleteIds\":[]}}', '更新站点配置信息', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 104, '2022-04-24 22:03:20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (4, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":32,\"nameEn\":\"qiniu\",\"nameZh\":\"七牛云配置\",\"value\":\"{\\\"id\\\":\\\"\\\",\\\"region\\\":\\\"华南\\\",\\\"AK\\\":\\\"\\\",\\\"SK\\\":\\\"\\\",\\\"doMain\\\":\\\"http://cdn.blog.xt-inn.com\\\",\\\"ak\\\":\\\"RfkcbXXEOGHredFc84c8Mbca9l0TyisCU_peCuWy\\\",\\\"sk\\\":\\\"3BKjHCIySqnsP009O2R9C0uHgkkEuj1EQo8uEQl3\\\"}\",\"type\":4}],\"deleteIds\":[]}}', '更新站点配置信息', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 126, '2022-04-24 22:06:16', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (5, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":32,\"nameEn\":\"qiniu\",\"nameZh\":\"七牛云配置\",\"value\":\"{\\\"id\\\":\\\"\\\",\\\"region\\\":\\\"华南\\\",\\\"doMain\\\":\\\"http://cdn.blog.xt-inn.com\\\",\\\"ak\\\":\\\"RfkcbXXEOGHredFc84c8Mbca9l0TyisCU_peCuWy\\\",\\\"sk\\\":\\\"3BKjHCIySqnsP009O2R9C0uHgkkEuj1EQo8uEQl3\\\",\\\"name\\\":\\\"xt-tll\\\"}\",\"type\":4}],\"deleteIds\":[]}}', '更新站点配置信息', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 285, '2022-04-24 23:09:09', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (6, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":32,\"nameEn\":\"qiniu\",\"nameZh\":\"七牛云配置\",\"value\":\"{\\\"id\\\":\\\"\\\",\\\"region\\\":\\\"华南\\\",\\\"doMain\\\":\\\"http://cdn.blog.xt-inn.com\\\",\\\"ak\\\":\\\"RfkcbXXEOGHredFc84c8Mbca9l0TyisCU_peCuWy\\\",\\\"sk\\\":\\\"3BKjHCIySqnsP009O2R9C0uHgkkEuj1EQo8uEQl3\\\",\\\"name\\\":\\\"xt-tll\\\"}\",\"type\":4}],\"deleteIds\":[]}}', '更新站点配置信息', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 6, '2022-04-24 23:09:31', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (7, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":32,\"nameEn\":\"qiniu\",\"nameZh\":\"七牛云配置\",\"value\":\"{\\\"region\\\":\\\"华南\\\",\\\"doMain\\\":\\\"http://cdn.blog.xt-inn.com\\\",\\\"ak\\\":\\\"RfkcbXXEOGHredFc84c8Mbca9l0TyisCU_peCuWy\\\",\\\"sk\\\":\\\"3BKjHCIySqnsP009O2R9C0uHgkkEuj1EQo8uEQl3\\\",\\\"name\\\":\\\"xt-tll\\\"}\",\"type\":4}],\"deleteIds\":[]}}', '更新站点配置信息', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 6, '2022-04-24 23:10:26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (8, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":32,\"nameEn\":\"qiniu\",\"nameZh\":\"七牛云配置\",\"value\":\"{\\\"region\\\":\\\"华南\\\",\\\"doMain\\\":\\\"http://cdn.blog.xt-inn.com\\\",\\\"ak\\\":\\\"RfkcbXXEOGHredFc84c8Mbca9l0TyisCU_peCuWy\\\",\\\"sk\\\":\\\"3BKjHCIySqnsP009O2R9C0uHgkkEuj1EQo8uEQl3\\\",\\\"name\\\":\\\"xt-tavern\\\"}\",\"type\":4}],\"deleteIds\":[]}}', '更新站点配置信息', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 552, '2022-04-25 20:33:49', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (9, 'Admin', '/admin/moment', 'POST', '{\"moment\":{\"id\":1,\"content\":\"\",\"createTime\":1650900818121,\"likes\":0,\"published\":true}}', '发布动态', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 458, '2022-04-25 23:33:39', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (10, 'Admin', '/admin/moment', 'DELETE', '{\"id\":1}', '删除动态', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 163, '2022-04-25 23:33:55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (11, 'Admin', '/admin/job', 'POST', '{\"scheduleJob\":{\"jobId\":3,\"beanName\":\"AttentionSyncScheduleTask\",\"methodName\":\"sendAliYunMessageInfo\",\"params\":\"{\\\"phone\\\":\\\"18316275848\\\",\\\"message\\\":{\\\"name\\\":\\\"定时任务\\\"}}\",\"cron\":\"0/30 * * * * ? \",\"status\":false,\"remark\":\"\",\"createTime\":1651243247807}}', '新建定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 322, '2022-04-29 22:40:48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (12, 'Admin', '/admin/job/status', 'PUT', '{\"jobId\":3,\"status\":true}', '更新任务状态', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 231, '2022-04-29 22:40:54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (13, 'Admin', '/admin/job', 'PUT', '{\"scheduleJob\":{\"jobId\":3,\"beanName\":\"attentionSyncScheduleTask\",\"methodName\":\"sendAliYunMessageInfo\",\"params\":\"{\\\"phone\\\":\\\"18316275848\\\",\\\"message\\\":{\\\"name\\\":\\\"定时任务\\\"}}\",\"cron\":\"0/30 * * * * ? \",\"status\":false,\"remark\":\"\",\"createTime\":1651243248000}}', '修改定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 104, '2022-04-29 23:01:05', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (14, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 88, '2022-04-29 23:01:14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (15, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 44, '2022-04-29 23:06:57', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (16, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 24, '2022-04-29 23:24:36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (17, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 4, '2022-04-29 23:27:12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (18, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 23, '2022-04-29 23:35:28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (19, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 57, '2022-04-29 23:54:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (20, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 43, '2022-04-30 00:39:22', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (21, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 36, '2022-04-30 01:10:52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (22, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 36, '2022-04-30 01:44:52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (23, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 27, '2022-04-30 01:49:28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (24, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 26, '2022-04-30 01:53:24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (25, 'Admin', '/admin/job', 'PUT', '{\"scheduleJob\":{\"jobId\":3,\"beanName\":\"attentionSyncScheduleTask\",\"methodName\":\"sendAliYunMessageInfo\",\"params\":\"{\\\"phone\\\":\\\"18316275848\\\",\\\"message\\\":{\\\"name\\\":\\\"定时任务\\\"}}\",\"cron\":\"0 0 8,12,15,18,20,22 1,3,7,9,10,12,15 1,4,7,10 ? \",\"status\":false,\"remark\":\"税务申报定时任务提醒\",\"createTime\":1651243248000}}', '修改定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 245, '2022-04-30 01:55:58', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (26, 'Admin', '/admin/job', 'PUT', '{\"scheduleJob\":{\"jobId\":3,\"beanName\":\"attentionSyncScheduleTask\",\"methodName\":\"sendAliYunMessageInfo\",\"params\":\"{\\\"phone\\\":\\\"18316275848\\\",\\\"message\\\":{\\\"name\\\":\\\"本季度税务申报\\\"}}\",\"cron\":\"0 0 8,12,15,18,20,22 1,3,7,9,10,12,15 1,4,7,10 ? \",\"status\":false,\"remark\":\"税务申报定时任务提醒\",\"createTime\":1651243248000}}', '修改定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 404, '2022-04-30 02:05:12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (27, 'Admin', '/admin/job/run', 'POST', '{\"jobId\":3}', '立即执行定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 3, '2022-04-30 02:05:15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (28, 'Admin', '/admin/job', 'PUT', '{\"scheduleJob\":{\"jobId\":3,\"beanName\":\"attentionSyncScheduleTask\",\"methodName\":\"sendAliYunMessageInfo\",\"params\":\"{\\\"phone\\\":\\\"18316275848\\\",\\\"message\\\":{\\\"name\\\":\\\"季度税务申报\\\"}}\",\"cron\":\"0 0 8,12,15,18,20,22 1,3,7,9,10,12,15 1,4,7,10 ? \",\"status\":false,\"remark\":\"税务申报定时任务提醒\",\"createTime\":1651243248000}}', '修改定时任务', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 372, '2022-04-30 02:16:44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (29, 'Admin', '/admin/job/status', 'PUT', '{\"jobId\":3,\"status\":true}', '更新任务状态', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 95, '2022-04-30 02:16:48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (30, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":1,\"nameEn\":\"blogName\",\"nameZh\":\"博客名称\",\"value\":\"Alan\'s Blog\",\"type\":1},{\"id\":2,\"nameEn\":\"webTitleSuffix\",\"nameZh\":\"网页标题后缀\",\"value\":\" - Alan\'s Blog\",\"type\":1},{\"id\":3,\"nameEn\":\"footerImgTitle\",\"nameZh\":\"页脚图片标题\",\"value\":\"手机看本站\",\"type\":1},{\"id\":4,\"nameEn\":\"footerImgUrl\",\"nameZh\":\"页脚图片路径\",\"value\":\"\",\"type\":1},{\"id\":5,\"nameEn\":\"copyright\",\"nameZh\":\"Copyright\",\"value\":\"{\\\"title\\\":\\\"Copyright © 2019 - 2022\\\",\\\"siteName\\\":\\\"NACCL\'S BLOG\\\"}\",\"type\":1},{\"id\":6,\"nameEn\":\"beian\",\"nameZh\":\"ICP备案号\",\"value\":\"\",\"type\":1},{\"id\":7,\"nameEn\":\"reward\",\"nameZh\":\"赞赏码\",\"value\":\"\",\"type\":1},{\"id\":8,\"nameEn\":\"commentAdminFlag\",\"nameZh\":\"博主评论标识\",\"value\":\"咕咕\",\"type\":1},{\"id\":9,\"nameEn\":\"avatar\",\"nameZh\":\"头像\",\"value\":\"/img/avatar.jpg\",\"type\":2},{\"id\":10,\"nameEn\":\"name\",\"nameZh\":\"昵称\",\"value\":\"Naccl\",\"type\":2},{\"id\":11,\"nameEn\":\"rollText\",\"nameZh\":\"滚动个签\",\"value\":\"\\\"云鹤当归天，天不迎我妙木仙；\\\",\\\"游龙当归海，海不迎我自来也。\\\"\",\"type\":2},{\"id\":12,\"nameEn\":\"github\",\"nameZh\":\"GitHub\",\"value\":\"https://github.com/Naccl\",\"type\":2},{\"id\":13,\"nameEn\":\"telegram\",\"nameZh\":\"Telegram\",\"value\":\"https://t.me/NacclOfficial\",\"type\":2},{\"id\":14,\"nameEn\":\"qq\",\"nameZh\":\"QQ\",\"value\":\"http://sighttp.qq.com/authd?IDKEY=\",\"type\":2},{\"id\":15,\"nameEn\":\"bilibili\",\"nameZh\":\"bilibili\",\"value\":\"https://space.bilibili.com/\",\"type\":2},{\"id\":16,\"nameEn\":\"netease\",\"nameZh\":\"网易云音乐\",\"value\":\"https://music.163.com/#/user/home?id=\",\"type\":2},{\"id\":17,\"nameEn\":\"email\",\"nameZh\":\"email\",\"value\":\"mailto:you@example.com\",\"type\":2},{\"id\":18,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢的动漫 📺\\\",\\\"content\\\":\\\"异度侵入、春物语、NO GAME NO LIFE、实力至上主义的教室、辉夜大小姐、青春猪头少年不会梦到兔女郎学姐、路人女主、Re0、魔禁、超炮、俺妹、在下坂本、散华礼弥、OVERLORD、慎勇、人渣的本愿、白色相簿2、死亡笔记、DARLING in the FRANXX、鬼灭之刃\\\"}\",\"type\":2},{\"id\":19,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢我的女孩子们 🤤\\\",\\\"content\\\":\\\"芙兰达、土间埋、食蜂操祈、佐天泪爷、樱岛麻衣、桐崎千棘、02、亚丝娜、高坂桐乃、五更琉璃、安乐冈花火、一色彩羽、英梨梨、珈百璃、时崎狂三、可儿那由多、和泉纱雾、早坂爱\\\"}\",\"type\":2},{\"id\":20,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢玩的游戏 🎮\\', '更新站点配置信息', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 493, '2022-05-01 17:55:34', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (31, 'Admin', '/admin/about', 'PUT', '{\"map\":{\"title\":\"关于帅气的 Alan\",\"musicId\":\"423015580\",\"content\":\"\",\"commentEnabled\":\"true\"}}', '修改关于我页面', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 143, '2022-05-01 17:57:08', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `operation_log` VALUES (32, 'Admin', '/admin/siteSettings', 'POST', '{\"map\":{\"settings\":[{\"id\":1,\"nameEn\":\"blogName\",\"nameZh\":\"博客名称\",\"value\":\"Alan\'s Blog\",\"type\":1},{\"id\":2,\"nameEn\":\"webTitleSuffix\",\"nameZh\":\"网页标题后缀\",\"value\":\" - Alan\'s Blog\",\"type\":1},{\"id\":3,\"nameEn\":\"footerImgTitle\",\"nameZh\":\"页脚图片标题\",\"value\":\"手机看本站\",\"type\":1},{\"id\":4,\"nameEn\":\"footerImgUrl\",\"nameZh\":\"页脚图片路径\",\"value\":\"\",\"type\":1},{\"id\":5,\"nameEn\":\"copyright\",\"nameZh\":\"Copyright\",\"value\":\"{\\\"title\\\":\\\"Copyright © 2019 - 2022\\\",\\\"siteName\\\":\\\"NACCL\'S BLOG\\\"}\",\"type\":1},{\"id\":6,\"nameEn\":\"beian\",\"nameZh\":\"ICP备案号\",\"value\":\"\",\"type\":1},{\"id\":7,\"nameEn\":\"reward\",\"nameZh\":\"赞赏码\",\"value\":\"\",\"type\":1},{\"id\":8,\"nameEn\":\"commentAdminFlag\",\"nameZh\":\"博主评论标识\",\"value\":\"咕咕\",\"type\":1},{\"id\":9,\"nameEn\":\"avatar\",\"nameZh\":\"头像\",\"value\":\"/img/avatar.jpg\",\"type\":2},{\"id\":10,\"nameEn\":\"name\",\"nameZh\":\"昵称\",\"value\":\"Alan\",\"type\":2},{\"id\":11,\"nameEn\":\"rollText\",\"nameZh\":\"滚动个签\",\"value\":\"\\\"云鹤当归天，天不迎我妙木仙；\\\",\\\"游龙当归海，海不迎我自来也。\\\"\",\"type\":2},{\"id\":12,\"nameEn\":\"github\",\"nameZh\":\"GitHub\",\"value\":\"https://github.com/Naccl\",\"type\":2},{\"id\":13,\"nameEn\":\"telegram\",\"nameZh\":\"Telegram\",\"value\":\"https://t.me/NacclOfficial\",\"type\":2},{\"id\":14,\"nameEn\":\"qq\",\"nameZh\":\"QQ\",\"value\":\"http://sighttp.qq.com/authd?IDKEY=\",\"type\":2},{\"id\":15,\"nameEn\":\"bilibili\",\"nameZh\":\"bilibili\",\"value\":\"https://space.bilibili.com/\",\"type\":2},{\"id\":16,\"nameEn\":\"netease\",\"nameZh\":\"网易云音乐\",\"value\":\"https://music.163.com/#/user/home?id=\",\"type\":2},{\"id\":17,\"nameEn\":\"email\",\"nameZh\":\"email\",\"value\":\"mailto:you@example.com\",\"type\":2},{\"id\":18,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢的动漫 📺\\\",\\\"content\\\":\\\"异度侵入、春物语、NO GAME NO LIFE、实力至上主义的教室、辉夜大小姐、青春猪头少年不会梦到兔女郎学姐、路人女主、Re0、魔禁、超炮、俺妹、在下坂本、散华礼弥、OVERLORD、慎勇、人渣的本愿、白色相簿2、死亡笔记、DARLING in the FRANXX、鬼灭之刃\\\"}\",\"type\":2},{\"id\":19,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢我的女孩子们 🤤\\\",\\\"content\\\":\\\"芙兰达、土间埋、食蜂操祈、佐天泪爷、樱岛麻衣、桐崎千棘、02、亚丝娜、高坂桐乃、五更琉璃、安乐冈花火、一色彩羽、英梨梨、珈百璃、时崎狂三、可儿那由多、和泉纱雾、早坂爱\\\"}\",\"type\":2},{\"id\":20,\"nameEn\":\"favorite\",\"nameZh\":\"自定义\",\"value\":\"{\\\"title\\\":\\\"最喜欢玩的游戏 🎮\\\"', '更新站点配置信息', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 377, '2022-05-01 19:02:07', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint NULL DEFAULT NULL COMMENT '任务状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES (1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', '0 0 1 * * ?', 1, '每天凌晨一点，从Redis将博客浏览量同步到数据库', '2020-11-17 23:45:42');
INSERT INTO `schedule_job` VALUES (2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', '0 0 0 * * ?', 1, '清空当天Redis访客标识，记录当天的PV和UV，更新当天所有访客的PV和最后访问时间，更新城市新增访客UV数', '2021-02-05 08:14:28');
INSERT INTO `schedule_job` VALUES (3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"季度税务申报\"}}', '0 0 8,12,15,18,20,22 1,3,7,9,10,12,15 1,4,7,10 ? ', 1, '税务申报定时任务提醒', '2022-04-29 22:40:48');

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log`  (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint NOT NULL COMMENT '任务id',
  `bean_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数',
  `status` tinyint NOT NULL COMMENT '任务执行结果',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常信息',
  `times` int NOT NULL COMMENT '耗时（单位：毫秒）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------
INSERT INTO `schedule_job_log` VALUES (1, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 912, '2022-03-14 00:00:00');
INSERT INTO `schedule_job_log` VALUES (2, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 459, '2022-04-25 00:00:00');
INSERT INTO `schedule_job_log` VALUES (3, 1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', 1, NULL, 814, '2022-04-25 01:00:00');
INSERT INTO `schedule_job_log` VALUES (4, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 2284, '2022-04-26 00:00:01');
INSERT INTO `schedule_job_log` VALUES (5, 1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', 1, NULL, 105, '2022-04-26 01:00:00');
INSERT INTO `schedule_job_log` VALUES (6, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 1576, '2022-04-27 00:00:00');
INSERT INTO `schedule_job_log` VALUES (7, 1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', 1, NULL, 422, '2022-04-27 01:00:00');
INSERT INTO `schedule_job_log` VALUES (8, 1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', 1, NULL, 182, '2022-04-28 01:00:01');
INSERT INTO `schedule_job_log` VALUES (9, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 2, '2022-04-29 22:41:00');
INSERT INTO `schedule_job_log` VALUES (10, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:41:30');
INSERT INTO `schedule_job_log` VALUES (11, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:42:00');
INSERT INTO `schedule_job_log` VALUES (12, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:42:30');
INSERT INTO `schedule_job_log` VALUES (13, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:43:00');
INSERT INTO `schedule_job_log` VALUES (14, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:43:30');
INSERT INTO `schedule_job_log` VALUES (15, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:44:00');
INSERT INTO `schedule_job_log` VALUES (16, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:44:30');
INSERT INTO `schedule_job_log` VALUES (17, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:45:00');
INSERT INTO `schedule_job_log` VALUES (18, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:45:30');
INSERT INTO `schedule_job_log` VALUES (19, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:46:00');
INSERT INTO `schedule_job_log` VALUES (20, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:46:30');
INSERT INTO `schedule_job_log` VALUES (21, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:47:00');
INSERT INTO `schedule_job_log` VALUES (22, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:47:30');
INSERT INTO `schedule_job_log` VALUES (23, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:48:00');
INSERT INTO `schedule_job_log` VALUES (24, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:48:30');
INSERT INTO `schedule_job_log` VALUES (25, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:49:00');
INSERT INTO `schedule_job_log` VALUES (26, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:49:30');
INSERT INTO `schedule_job_log` VALUES (27, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:50:00');
INSERT INTO `schedule_job_log` VALUES (28, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:50:30');
INSERT INTO `schedule_job_log` VALUES (29, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:51:00');
INSERT INTO `schedule_job_log` VALUES (30, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:51:30');
INSERT INTO `schedule_job_log` VALUES (31, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:52:00');
INSERT INTO `schedule_job_log` VALUES (32, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:52:30');
INSERT INTO `schedule_job_log` VALUES (33, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:53:00');
INSERT INTO `schedule_job_log` VALUES (34, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:53:30');
INSERT INTO `schedule_job_log` VALUES (35, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:54:00');
INSERT INTO `schedule_job_log` VALUES (36, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:54:30');
INSERT INTO `schedule_job_log` VALUES (37, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:55:00');
INSERT INTO `schedule_job_log` VALUES (38, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:55:30');
INSERT INTO `schedule_job_log` VALUES (39, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:56:00');
INSERT INTO `schedule_job_log` VALUES (40, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:56:30');
INSERT INTO `schedule_job_log` VALUES (41, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:57:00');
INSERT INTO `schedule_job_log` VALUES (42, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:57:30');
INSERT INTO `schedule_job_log` VALUES (43, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 22:58:00');
INSERT INTO `schedule_job_log` VALUES (44, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:58:30');
INSERT INTO `schedule_job_log` VALUES (45, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:59:00');
INSERT INTO `schedule_job_log` VALUES (46, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 22:59:30');
INSERT INTO `schedule_job_log` VALUES (47, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 0, '2022-04-29 23:00:00');
INSERT INTO `schedule_job_log` VALUES (48, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 23:00:30');
INSERT INTO `schedule_job_log` VALUES (49, 3, 'AttentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 0, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'AttentionSyncScheduleTask\' available', 1, '2022-04-29 23:01:00');
INSERT INTO `schedule_job_log` VALUES (50, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 516, '2022-04-29 23:01:14');
INSERT INTO `schedule_job_log` VALUES (51, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 682, '2022-04-29 23:06:57');
INSERT INTO `schedule_job_log` VALUES (52, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 478, '2022-04-29 23:24:36');
INSERT INTO `schedule_job_log` VALUES (53, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 63455, '2022-04-29 23:27:12');
INSERT INTO `schedule_job_log` VALUES (54, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 8922, '2022-04-29 23:35:28');
INSERT INTO `schedule_job_log` VALUES (55, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 1809, '2022-04-29 23:54:35');
INSERT INTO `schedule_job_log` VALUES (56, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 295, '2022-04-30 00:00:00');
INSERT INTO `schedule_job_log` VALUES (57, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 29444, '2022-04-30 00:39:22');
INSERT INTO `schedule_job_log` VALUES (58, 1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', 1, NULL, 247, '2022-04-30 01:00:00');
INSERT INTO `schedule_job_log` VALUES (59, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 11625, '2022-04-30 01:10:52');
INSERT INTO `schedule_job_log` VALUES (60, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 5672, '2022-04-30 01:44:52');
INSERT INTO `schedule_job_log` VALUES (61, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 20687, '2022-04-30 01:49:28');
INSERT INTO `schedule_job_log` VALUES (62, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"定时任务\"}}', 1, NULL, 3019, '2022-04-30 01:53:24');
INSERT INTO `schedule_job_log` VALUES (63, 3, 'attentionSyncScheduleTask', 'sendAliYunMessageInfo', '{\"phone\":\"18316275848\",\"message\":{\"name\":\"本季度税务申报\"}}', 1, NULL, 678, '2022-04-30 02:05:15');
INSERT INTO `schedule_job_log` VALUES (64, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 1019, '2022-05-02 00:00:01');
INSERT INTO `schedule_job_log` VALUES (65, 1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', 1, NULL, 359, '2022-05-02 01:00:00');

-- ----------------------------
-- Table structure for site_setting
-- ----------------------------
DROP TABLE IF EXISTS `site_setting`;
CREATE TABLE `site_setting`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name_zh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `type` int NULL DEFAULT NULL COMMENT '1基础设置，2页脚徽标，3资料卡，4友链信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of site_setting
-- ----------------------------
INSERT INTO `site_setting` VALUES (1, 'blogName', '博客名称', 'Alan\'s Blog', 1);
INSERT INTO `site_setting` VALUES (2, 'webTitleSuffix', '网页标题后缀', ' - Alan\'s Blog', 1);
INSERT INTO `site_setting` VALUES (3, 'footerImgTitle', '页脚图片标题', '手机看本站', 1);
INSERT INTO `site_setting` VALUES (4, 'footerImgUrl', '页脚图片路径', '', 1);
INSERT INTO `site_setting` VALUES (5, 'copyright', 'Copyright', '{\"title\":\"Copyright © 2019 - 2022\",\"siteName\":\"NACCL\'S BLOG\"}', 1);
INSERT INTO `site_setting` VALUES (6, 'beian', 'ICP备案号', '', 1);
INSERT INTO `site_setting` VALUES (7, 'reward', '赞赏码', '', 1);
INSERT INTO `site_setting` VALUES (8, 'commentAdminFlag', '博主评论标识', '咕咕', 1);
INSERT INTO `site_setting` VALUES (9, 'avatar', '头像', '/img/avatar.jpg', 2);
INSERT INTO `site_setting` VALUES (10, 'name', '昵称', 'Alan', 2);
INSERT INTO `site_setting` VALUES (11, 'rollText', '滚动个签', '\"云鹤当归天，天不迎我妙木仙；\",\"游龙当归海，海不迎我自来也。\"', 2);
INSERT INTO `site_setting` VALUES (12, 'github', 'GitHub', 'https://github.com/Naccl', 2);
INSERT INTO `site_setting` VALUES (13, 'telegram', 'Telegram', 'https://t.me/NacclOfficial', 2);
INSERT INTO `site_setting` VALUES (14, 'qq', 'QQ', 'http://sighttp.qq.com/authd?IDKEY=', 2);
INSERT INTO `site_setting` VALUES (15, 'bilibili', 'bilibili', 'https://space.bilibili.com/', 2);
INSERT INTO `site_setting` VALUES (16, 'netease', '网易云音乐', 'https://music.163.com/#/user/home?id=', 2);
INSERT INTO `site_setting` VALUES (17, 'email', 'email', 'mailto:you@example.com', 2);
INSERT INTO `site_setting` VALUES (18, 'favorite', '自定义', '{\"title\":\"最喜欢的动漫 📺\",\"content\":\"异度侵入、春物语、NO GAME NO LIFE、实力至上主义的教室、辉夜大小姐、青春猪头少年不会梦到兔女郎学姐、路人女主、Re0、魔禁、超炮、俺妹、在下坂本、散华礼弥、OVERLORD、慎勇、人渣的本愿、白色相簿2、死亡笔记、DARLING in the FRANXX、鬼灭之刃\"}', 2);
INSERT INTO `site_setting` VALUES (19, 'favorite', '自定义', '{\"title\":\"最喜欢我的女孩子们 🤤\",\"content\":\"芙兰达、土间埋、食蜂操祈、佐天泪爷、樱岛麻衣、桐崎千棘、02、亚丝娜、高坂桐乃、五更琉璃、安乐冈花火、一色彩羽、英梨梨、珈百璃、时崎狂三、可儿那由多、和泉纱雾、早坂爱\"}', 2);
INSERT INTO `site_setting` VALUES (20, 'favorite', '自定义', '{\"title\":\"最喜欢玩的游戏 🎮\",\"content\":\"Stellaris、巫师、GTA、荒野大镖客、刺客信条、魔兽争霸、LOL、PUBG\"}', 2);
INSERT INTO `site_setting` VALUES (21, 'badge', '徽标', '{\"title\":\"本博客已开源于 GitHub\",\"url\":\"https://github.com/Naccl/NBlog\",\"subject\":\"NBlog\",\"value\":\"Open Source\",\"color\":\"brightgreen\"}', 3);
INSERT INTO `site_setting` VALUES (22, 'badge', '徽标', '{\"title\":\"由 Spring Boot 强力驱动\",\"url\":\"https://spring.io/projects/spring-boot/\",\"subject\":\"Powered\",\"value\":\"Spring Boot\",\"color\":\"blue\"}', 3);
INSERT INTO `site_setting` VALUES (23, 'badge', '徽标', '{\"title\":\"Vue.js 客户端渲染\",\"url\":\"https://cn.vuejs.org/\",\"subject\":\"SPA\",\"value\":\"Vue.js\",\"color\":\"brightgreen\"}', 3);
INSERT INTO `site_setting` VALUES (24, 'badge', '徽标', '{\"title\":\"UI 框架 Semantic-UI\",\"url\":\"https://semantic-ui.com/\",\"subject\":\"UI\",\"value\":\"Semantic-UI\",\"color\":\"semantic-ui\"}', 3);
INSERT INTO `site_setting` VALUES (25, 'badge', '徽标', '{\"title\":\"阿里云提供服务器及域名相关服务\",\"url\":\"https://www.aliyun.com/\",\"subject\":\"VPS & DNS\",\"value\":\"Aliyun\",\"color\":\"blueviolet\"}', 3);
INSERT INTO `site_setting` VALUES (26, 'badge', '徽标', '{\"title\":\"静态资源托管于 GitHub\",\"url\":\"https://github.com/\",\"subject\":\"OSS\",\"value\":\"GitHub\",\"color\":\"github\"}', 3);
INSERT INTO `site_setting` VALUES (27, 'badge', '徽标', '{\"title\":\"jsDelivr 加速静态资源\",\"url\":\"https://www.jsdelivr.com/\",\"subject\":\"CDN\",\"value\":\"jsDelivr\",\"color\":\"orange\"}', 3);
INSERT INTO `site_setting` VALUES (28, 'badge', '徽标', '{\"color\":\"lightgray\",\"subject\":\"CC\",\"title\":\"本站点采用 CC BY 4.0 国际许可协议进行许可\",\"url\":\"https://creativecommons.org/licenses/by/4.0/\",\"value\":\"BY 4.0\"}', 3);
INSERT INTO `site_setting` VALUES (29, 'friendContent', '友链页面信息', '随机排序，不分先后。欢迎交换友链~(￣▽￣)~*\n\n* 昵称：Naccl\n* 一句话：游龙当归海，海不迎我自来也。\n* 网址：[https://naccl.top](https://naccl.top)\n* 头像URL：[https://naccl.top/img/avatar.jpg](https://naccl.top/img/avatar.jpg)\n\n仅凭个人喜好添加友链，请在收到我的回复邮件后再于贵站添加本站链接。原则上已添加的友链不会删除，如果你发现自己被移除了，恕不另行通知，只需和我一样做就好。\n\n', 4);
INSERT INTO `site_setting` VALUES (30, 'friendCommentEnabled', '友链页面评论开关', '1', 4);
INSERT INTO `site_setting` VALUES (31, 'siteIndexPic', '站点首页图片', NULL, 4);
INSERT INTO `site_setting` VALUES (32, 'qiniu', '七牛云配置', '{\"region\":\"华南\",\"doMain\":\"http://cdn.blog.xt-inn.com\",\"ak\":\"RfkcbXXEOGHredFc84c8Mbca9l0TyisCU_peCuWy\",\"sk\":\"3BKjHCIySqnsP009O2R9C0uHgkkEuj1EQo8uEQl3\",\"name\":\"xt-tavern\"}', 4);

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签颜色(可选)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像地址',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色访问权限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Admin', '$2a$10$4wnwMW8Z4Bn6wR4K1YlbquQunlHM/4rvudVBX8oyfx16xeVtI6i7C', 'Admin', '/img/avatar.jpg', 'admin@naccl.top', '2020-09-21 16:47:18', '2020-09-21 16:47:22', 'ROLE_admin');

-- ----------------------------
-- Table structure for visit_log
-- ----------------------------
DROP TABLE IF EXISTS `visit_log`;
CREATE TABLE `visit_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访客标识码',
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求参数',
  `behavior` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问行为',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问内容',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `times` int NOT NULL COMMENT '请求耗时（毫秒）',
  `create_time` datetime NOT NULL COMMENT '访问时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of visit_log
-- ----------------------------
INSERT INTO `visit_log` VALUES (1, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 99.0.4844.51', 424, '2022-03-13 17:22:27', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36');
INSERT INTO `visit_log` VALUES (2, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 161, '2022-05-01 17:25:46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (3, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 3, '2022-05-01 17:47:41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (4, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 790, '2022-05-01 17:48:11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (5, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 3, '2022-05-01 17:55:02', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (6, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 2, '2022-05-01 17:55:58', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (7, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 5, '2022-05-01 17:56:04', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (8, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/archives', 'GET', '{}', '访问页面', '归档', '', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 92, '2022-05-01 17:56:12', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (9, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/moments', 'GET', '{\"pageNum\":1}', '访问页面', '动态', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 22, '2022-05-01 17:56:13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (10, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 5, '2022-05-01 17:56:15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (11, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/about', 'GET', '{}', '访问页面', '关于我', '', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 19, '2022-05-01 17:56:15', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (12, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/about', 'GET', '{}', '访问页面', '关于我', '', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 7, '2022-05-01 17:57:11', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (13, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/about', 'GET', '{}', '访问页面', '关于我', '', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 2, '2022-05-01 19:02:35', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (14, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 18, '2022-05-01 19:22:13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (15, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/moments', 'GET', '{\"pageNum\":1}', '访问页面', '动态', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 7, '2022-05-01 19:22:13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (16, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/archives', 'GET', '{}', '访问页面', '归档', '', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 2, '2022-05-01 19:22:14', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (17, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 5, '2022-05-01 19:22:20', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (18, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/about', 'GET', '{}', '访问页面', '关于我', '', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 2, '2022-05-01 19:22:29', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (19, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 3, '2022-05-01 19:27:52', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (20, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 49, '2022-05-01 20:25:51', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');
INSERT INTO `visit_log` VALUES (21, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 100.0.4896.127', 86, '2022-05-01 20:26:03', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36');

-- ----------------------------
-- Table structure for visit_record
-- ----------------------------
DROP TABLE IF EXISTS `visit_record`;
CREATE TABLE `visit_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pv` int NOT NULL COMMENT '访问量',
  `uv` int NOT NULL COMMENT '独立用户',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日期\"02-23\"',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of visit_record
-- ----------------------------
INSERT INTO `visit_record` VALUES (1, 1, 1, '03-13');
INSERT INTO `visit_record` VALUES (2, 0, 0, '04-24');
INSERT INTO `visit_record` VALUES (3, 0, 0, '04-25');
INSERT INTO `visit_record` VALUES (4, 0, 0, '04-26');
INSERT INTO `visit_record` VALUES (5, 0, 0, '04-29');
INSERT INTO `visit_record` VALUES (6, 20, 1, '05-01');

-- ----------------------------
-- Table structure for visitor
-- ----------------------------
DROP TABLE IF EXISTS `visitor`;
CREATE TABLE `visitor`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '访客标识码',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '首次访问时间',
  `last_time` datetime NOT NULL COMMENT '最后访问时间',
  `pv` int NULL DEFAULT NULL COMMENT '访问页数统计',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of visitor
-- ----------------------------
INSERT INTO `visitor` VALUES (1, 'b99b6f96-6499-3220-a27f-5312cacff4c6', '192.168.112.1', '内网IP|内网IP', 'Windows 10', 'Chrome 99.0.4844.51', '2022-03-13 17:22:27', '2022-05-01 20:26:03', 21, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36');

SET FOREIGN_KEY_CHECKS = 1;
