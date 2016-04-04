<?php
if(!empty($this->data['htmlinject']['htmlContentPost'])) {
    foreach($this->data['htmlinject']['htmlContentPost'] AS $c) {
        echo $c;
    }
}
?>

<!-- Divs to close header rows -->
    </div>
</div>

<!-- Sticky footer -->
<footer class="footer">
    <div class="container" >
        <img src="/<?php echo $this->data['baseurlpath']; ?>resources/icons/ssplogo-fish-small.png" alt="Small fish logo"/>

        Copyright &copy; 2007-2015 <a href="http://uninett.no/">UNINETT AS</a>
    </div>
</footer>

</body>
</html>
