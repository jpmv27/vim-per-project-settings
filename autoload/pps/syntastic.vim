function! pps#syntastic#disable() abort
    let b:syntastic_skip_checks = 1
    SyntasticReset
endfunction


