from slither.slither import Slither


def detect_state_variable_packing(slither: Slither):
    """
    Detects state variable packing inefficiencies in the Solidity contract.
    """
    results = []

    for contract in slither.contracts:
        result = {"analysis_type": "detect_state_variable_packing", "contract_name":contract.name}
        current_state_variable_order = []
        if len(contract.variables) == 1:
            result["message"] = "Only one variable - no reorder required"
            results.append(result)
            continue
        for variable in contract.variables:
           current_state_variable_order.append({"variable_name":variable.name,"variable_type":str(variable.type),"variable_size_bytes":variable.type.storage_size[0]})
        result["current_state_variable_order"] = current_state_variable_order
        result["recommended_state_variable_order"] = sorted(current_state_variable_order, key=lambda x: x['variable_size_bytes'], reverse=True)
        results.append(result)
                
    return results




