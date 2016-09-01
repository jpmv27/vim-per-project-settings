function! pps#project_callback(project) abort
    let b:pps_project_name = a:project

    call pps#utils#apply_settings()
endfunction

