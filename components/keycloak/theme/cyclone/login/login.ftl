<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo displayCyclone=true; section>
    <#if section = "title">
        ${msg("loginTitle",(realm.displayName!''))}
    <#elseif section = "header">
        ${msg("loginTitleHtml",(realm.displayNameHtml!''))}
    <#elseif section = "form">
        <#if realm.password>
            <a id="cy-local-toggle" href="#kc-form" onclick="var doc=document.getElementById('cy-local-login');doc.style.visibility=(doc.style.visibility!=='visible')?'visible':'collapse';">Local Login</a>
            <form id="cy-local-login" class="${properties.cyLocalLoginClass!}" action="${url.loginAction}" method="post">
		        <#if realm.password && realm.registrationAllowed && !usernameEditDisabled??>
        		    <div id="kc-registration">
        	        	<span>${msg("noAccount")} <a href="${url.registrationUrl}">${msg("doRegister")}</a></span>
		            </div>
		        </#if>

                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.cyInputWrapperClass!}">
                        <#if usernameEditDisabled??>
						    <input id="username" placeholder="<#if !realm.registrationEmailAsUsername>${msg('usernameOrEmail')}<#else>${msg("email")}</#if>" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')?html}" type="text" disabled />
                        <#else>
                            <input id="username" placeholder="<#if !realm.registrationEmailAsUsername>${msg('usernameOrEmail')}<#else>${msg("email")}</#if>" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')?html}" type="text" autofocus />
                        </#if>
                    </div>
                </div>

                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.cyInputWrapperClass!}">
							<input id="password" placeholder="${msg('password')}" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off" />
                    </div>
                    <#if realm.rememberMe && !usernameEditDisabled??>
                        <div id="remember-checkbox" class="checkbox">
                            <label>
                                <#if login.rememberMe??>
                                    <input id="rememberMe" name="rememberMe" type="checkbox" tabindex="3" checked> ${msg("rememberMe")}
                                <#else>
                                    <input id="rememberMe" name="rememberMe" type="checkbox" tabindex="3"> ${msg("rememberMe")}
                                </#if>
                            </label>
                        </div>
                    </#if>
               </div>

                <div class="${properties.kcFormGroupClass!}">
                    <div id="cy-form-buttons" class="${properties.cyFormButtonsClass!}">
                        <div class="${properties.kcFormButtonsWrapperClass!}">
                            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="login" id="cy-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>
                        <div id="kc-form-options-wrapper" class="${properties.cyFormOptionsWrapperClass!}">
                            <#if realm.resetPasswordAllowed>
                                <span><a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                            </#if>
                        </div>
                    </div>
                </div>
            </form>
        </#if>
    <#elseif section = "info" >
        <h2 id="cy-info-title">Login with..</h2>
        <#if realm.password && social.providers??>
            <div id="kc-social-providers">
                <ul>
                    <#list social.providers as p>
                        <li><a href="${p.loginUrl}" id="zocial-${p.alias}" class="btn btn-primary cy-btn-social"> <span class="text">${p.alias}</span></a></li>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
