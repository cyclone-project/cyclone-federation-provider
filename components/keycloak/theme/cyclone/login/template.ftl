<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayCyclone=false>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title><#nested "title"></title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>

<body class="${properties.kcBodyClass!}">
    <div id="kc-logo">
        <a href="${properties.kcLogoLink!'#'}"><div id="kc-logo-wrapper"></div>
            <div id="kc-header" class="${properties.kcHeaderClass!}">
                <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}">
                    <#nested "header">                    
                </div>
            </div>
        </a>
    </div>

    <div id="kc-container" class="${properties.kcContainerClass!}">

        <#if displayCyclone>
            <div id="cy-content" class="${properties.cyContentClass!}">
                <div id="cy-content-wrapper" class="${properties.cyContentWrapperClass!}">

                    <#if displayMessage && message?has_content>
                        <div class="${properties.kcFeedbackAreaClass!}">
                            <div class="alert alert-${message.type}">
                                <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon}"></span></#if>
                                <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon}"></span></#if>
                                <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon}"></span></#if>
                                <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon}"></span></#if>
                                <span class="kc-feedback-text">${message.summary}</span>
                            </div>
                        </div>
                    </#if>

                    <#if displayInfo>
                        <div id="cy-info" class="${properties.cyInfoAreaClass!}">                            
                            <div id="cy-info-wrapper" class="${properties.cyInfoAreaWrapperClass!}">
                                <#nested "info">
                            </div>
                        </div>
                    </#if>

                    <div id="cy-form" class="${properties.cyFormAreaClass!}">
                        <div id="cy-form-wrapper" class="${properties.cyFormAreaWrapperClass!}">
                            <#nested "form">
                        </div>
                    </div>
                    
                </div>
            </div>            
        </#if>

        <div id="kc-container-wrapper" class="${properties.kcContainerWrapperClass!}">            
            <#if realm.internationalizationEnabled>
                <div id="kc-locale" class="${properties.kcLocaleClass!}">
                    <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                        <div class="kc-dropdown" id="kc-locale-dropdown">
                            <a href="#" id="kc-current-locale-link">${locale.current}</a>
                            <ul>
                                <#list locale.supported as l>
                                    <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                </div>
            </#if>

            <#if !displayCyclone>
                <div id="kc-content" class="${properties.kcContentClass!}">
                    <div id="kc-content-wrapper" class="${properties.kcContentWrapperClass!}">
    
                        <#if displayMessage && message?has_content>
                            <div class="${properties.kcFeedbackAreaClass!}">
                                <div class="alert alert-${message.type}">
                                    <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon}"></span></#if>
                                    <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon}"></span></#if>
                                    <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon}"></span></#if>
                                    <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon}"></span></#if>
                                    <span class="kc-feedback-text">${message.summary}</span>
                                </div>
                            </div>
                        </#if>
    
                        <div id="kc-form" class="${properties.kcFormAreaClass!}">
                            <div id="kc-form-wrapper" class="${properties.kcFormAreaWrapperClass!}">
                                <#nested "form">
                            </div>
                        </div>
    
                        <#if displayInfo>
                            <div id="kc-info" class="${properties.kcInfoAreaClass!}">
                                <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                                    <#nested "info">
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
            </#if>
        </div>
    </div>
</body>
</html>
</#macro>
