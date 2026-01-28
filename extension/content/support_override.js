(() => {
    const SUPPORT_PHONE = "5593991513915";
    const TARGET_TEXTS = [
        "Falar com o suporte",
        "Entre em contato com o suporte",
        "Hablar con soporte", // Spanish
        "Contact support" // English
    ];

    function handleSupportClick(e) {
        e.preventDefault();
        e.stopPropagation();
        window.open(`https://wa.me/${SUPPORT_PHONE}`, '_blank');
    }

    function attachListener(element) {
        if (element.dataset.supportListenerAttached) return;
        
        // Use capture phase to ensure we handle it first
        element.addEventListener('click', handleSupportClick, true);
        element.dataset.supportListenerAttached = "true";
        
        // Visual indicator that it's hooked (optional, for debug)
        // element.style.border = "1px solid red"; 
    }

    const observer = new MutationObserver((mutations) => {
        for (const mutation of mutations) {
            for (const node of mutation.addedNodes) {
                if (node.nodeType === 1) { // Element node
                    // Check the node itself
                    checkNode(node);
                    // Check descendants
                    const elements = node.querySelectorAll('*');
                    elements.forEach(checkNode);
                }
            }
        }
    });

    function checkNode(node) {
        if (!node.textContent) return;
        
        const text = node.textContent.trim();
        // Check if text mostly matches one of the targets
        // (Exact match might fail if there are icons or whitespace)
        const match = TARGET_TEXTS.some(target => text.includes(target));
        
        if (match) {
            // It might be the button itself or a child span. 
            // We want the clickable element. 
            // Usually the button element or an anchor.
            let clickable = node;
            if (node.tagName !== 'BUTTON' && node.tagName !== 'A' && node.getAttribute('role') !== 'button') {
                clickable = node.closest('button, a, [role="button"]') || node;
            }
            
            attachListener(clickable);
        }
    }

    // Start observing
    observer.observe(document.body, {
        childList: true,
        subtree: true
    });

    // Initial check in case it's already there (unlikely on fresh load but good practice)
    document.querySelectorAll('*').forEach(checkNode);

    console.log("LEMOS CRM: Support override script loaded.");
})();
