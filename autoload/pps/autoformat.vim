function! pps#autoformat#enable() abort
    augroup pps_af
        autocmd!
        autocmd BufWrite <buffer> :Autoformat
    augroup END
endfunction

