<?php
$this->data['header'] = $this->t('{login:user_pass_header}');

if (strlen($this->data['username']) > 0) {
    $this->data['autofocus'] = 'password';
} else {
    $this->data['autofocus'] = 'username';
}
$this->includeAtTemplateBase('includes/header.php');

?>

<?php
if ($this->data['errorcode'] !== null) {
    ?>
    <div style="border-left: 1px solid #e8e8e8; border-bottom: 1px solid #e8e8e8; background: #f5f5f5">
        <img src="/<?php echo $this->data['baseurlpath']; ?>resources/icons/experience/gtk-dialog-error.48x48.png"
             class="float-l erroricon" style="margin: 15px" alt=""/>

        <h2><?php echo $this->t('{login:error_header}'); ?></h2>

        <p><strong><?php
                echo htmlspecialchars($this->t(
                    '{errors:title_' . $this->data['errorcode'] . '}',
                    $this->data['errorparams']
                )); ?></strong></p>

        <p><?php
            echo htmlspecialchars($this->t(
                '{errors:descr_' . $this->data['errorcode'] . '}',
                $this->data['errorparams']
            )); ?></p>
    </div>
    <?php
}

?>
    <h2 style="break: both"><?php echo $this->t('{login:user_pass_header}'); ?></h2>

    <p class="logintext"><?php echo $this->t('{login:user_pass_text}'); ?></p>


    <form class="form-horizontal" action="?" method="post" name="f">

        <img id="loginicon" alt=""
             src="/<?php echo $this->data['baseurlpath']; ?>resources/icons/experience/gtk-dialog-authentication.48x48.png"/>

        <!-- Username -->
        <div class="form-group">
            <label for="username" class="col-sm-2 control-label"><?php echo $this->t('{login:username}'); ?></label>
            <div class="col-sm-3">
                <input id="username"
                       class="form-control" <?php echo ($this->data['forceUsername']) ? 'disabled="disabled"' : ''; ?>
                       type="text" name="username"
                    <?php if (!$this->data['forceUsername']) {
                        echo 'tabindex="1"';
                    } ?> value="<?php echo htmlspecialchars($this->data['username']); ?>"/>
            </div>
        </div>


        <!-- Remember username -->
        <?php
        if ($this->data['rememberUsernameEnabled'] && !$this->data['forceUsername']) {
            // display the "remember my username" checkbox
            ?>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-3">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" id="remember_username" tabindex="4"
                                <?php echo ($this->data['rememberUsernameChecked']) ? 'checked="checked"' : ''; ?>
                                   name="remember_username" value="Yes"/>
                            <?php echo $this->t('{login:remember_username}'); ?>
                        </label>
                    </div>
                </div>
            </div>

            <?php
        }
        ?>


        <!-- Password -->
        <div class="form-group">
            <label for="password" class="col-sm-2 control-label"><?php echo $this->t('{login:password}'); ?></label>
            <div class="col-sm-3">
                <input id="password" type="password" class="form-control" tabindex="2" name="password"/>
            </div>
        </div>


        <!-- Remember me -->
        <?php
        if ($this->data['rememberMeEnabled']) {
            // display the remember me checkbox (keep me logged in)
            ?>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-3">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" id="remember_me" tabindex="5"
                                <?php echo ($this->data['rememberMeChecked']) ? 'checked="checked"' : ''; ?>
                                   name="remember_me" value="Yes"/>
                            <?php echo $this->t('{login:remember_me}'); ?>
                        </label>
                    </div>
                </div>
            </div>

            <?php
        }
        if (array_key_exists('organizations', $this->data)) {
            ?>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-3">
                    <label for="organization" class="col-sm-2 control-label">
                        <?php echo $this->t('{login:organization}'); ?>
                        <select class="form-control" name="organization" tabindex="3">
                            <?php
                        if (array_key_exists('selectedOrg', $this->data)) {
                            $selectedOrg = $this->data['selectedOrg'];
                            } else {
                            $selectedOrg = null;
                            }

                            foreach ($this->data['organizations'] as $orgId => $orgDesc) {
                            if (is_array($orgDesc)) {
                            $orgDesc = $this->t($orgDesc);
                            }

                            if ($orgId === $selectedOrg) {
                            $selected = 'selected="selected" ';
                            } else {
                            $selected = '';
                            }

                            echo '
                            <option
                            ' . $selected . 'value="' . htmlspecialchars($orgId) . '">' . htmlspecialchars($orgDesc) .
                            '</option>';
                            }
                            ?>
                        </select>
                    </label>
                </div>
            </div>
            <?php
        }
        ?>


        <!-- Submit button -->
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button id="regularsubmit" type="submit" class="btn btn-default"
                        onclick="this.value='<?php echo $this->t('{login:processing'); ?>';
                            this.disabled=true; this.form.submit(); return true;" tabindex="6">
                    <?php echo $this->t('{login:login_button}'); ?>
                </button>
            </div>
        </div>

        <?php
        foreach ($this->data['stateparams'] as $name => $value) {
            echo('<input type="hidden" name="' . htmlspecialchars($name) . '" value="' . htmlspecialchars($value) . '" />');
        }
        ?>

    </form>
<?php
if (!empty($this->data['links'])) {
    echo '<ul class="links" style="margin-top: 2em">';
    foreach ($this->data['links'] as $l) {
        echo '<li><a href="' . htmlspecialchars($l['href']) . '">' . htmlspecialchars($this->t($l['text'])) . '</a></li>';
    }
    echo '</ul>';
}
echo('<h2 class="logintext">' . $this->t('{login:help_header}') . '</h2>');
echo('<p class="logintext">' . $this->t('{login:help_text}') . '</p>');

$this->includeAtTemplateBase('includes/footer.php');
