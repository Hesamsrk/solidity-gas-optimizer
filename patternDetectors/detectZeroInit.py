from slither.slither import Slither


def detect_zero_init(slither: Slither):
    """
    Detects auto initialize to zeros in the Solidity contract.
    """
    results = []

    for contract in slither.contracts:
        result = {"analysis_type": "detect_zero_init", "contract_name":contract.name}
        auto_initialized_vars = [i for i in contract.variables if not i.initialized]
        if len(auto_initialized_vars) == 0:
            result["message"] = "No auto initialized vars - no optimization required"
            results.append(result)
            continue
       
        result["auto_initialized_vars"] = [{"var_name":var.name,"var_type":str(var.type)} for var in auto_initialized_vars]
        result["message"] = "These variables will be auto initialized to their zero value - consider intializing them to the zero value explicitly."
        results.append(result)
                        
    return results