from slither.slither import Slither


def detect_external_public_functions(slither: Slither):
    """
    Detects if any external or public function can be set as internal of private.
    """
    results = []

    for contract in slither.contracts:
        result = {"analysis_type": "detect_external_public_functions", "contract_name":contract.name}
        public_external_functions = [{"function_name":f.name,"visibility":f.visibility,"internal_calls":len(f.internal_calls),"external_calls":len(f.external_calls_as_expressions)} for f in contract.functions if not f.is_constructor and f.visibility!="private" and f.visibility!="internal"]
        if len(public_external_functions) == 0:
            result["message"] = "No public or external functions - no optimization required"
            results.append(result)
            continue
        result["public_external_functions"] = public_external_functions
        result["message"] = "To optimize gas consumption, consider making functions internal whenever possible. If a function must be publicly accessible, mark it as external to utilize calldata for parameter passing, which is generally more gas-efficient than memory."
        results.append(result)

    return results