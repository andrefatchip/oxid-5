[{if $blFCPOAmazonCatchHash}]
    <script>
        function getURLParameter(name, source) {
            return decodeURIComponent((new RegExp('[?|&|#]' + name + '=' +
                '([^&]+?)(&|#|;|$)').exec(source) || [,""])[1].replace(/\+/g,
                '%20')) || null;
        }

        var accessToken = getURLParameter("access_token", location.hash);
        if (typeof accessToken === 'string' && accessToken.match(/^Atza/)) {
            document.cookie = "amazon_Login_accessToken=" + accessToken +
                ";secure";
            // and do it again
            var addRedirectParameters = '&token_type=bearer&expires_in=3600&scope=payments%3Abilling_address payments%3Ashipping_address payments%3Awidget profile';
            document.location.href = '[{$oViewConf->fcpoGetAmazonRedirectUrl()}]&access_token=' + accessToken + addRedirectParameters;
        }
    </script>
[{/if}]

[{if $oView->fcpoGetUserErrorMessage()}]
    [{assign var="sFcPoTemplatePath" value=$oViewConf->fcpoGetActiveThemePath()}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_user_errormessage.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{/if}]

[{if $oViewConf->fcpoAmazonLoginSessionActive()}]
    [{assign var="sFcPoTemplatePath" value=$oViewConf->fcpoGetActiveThemePath()}]
    [{assign var="sFcPoTemplatePath" value=$sFcPoTemplatePath|cat:'/fcpo_amazonpay_user.tpl'}]
    [{include file=$oViewConf->fcpoGetAbsModuleTemplateFrontendPath($sFcPoTemplatePath)}]
[{else}]
    [{$smarty.block.parent}]
[{/if}]