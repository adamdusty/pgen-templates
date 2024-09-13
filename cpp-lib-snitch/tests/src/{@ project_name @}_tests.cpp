#include <snitch/snitch.hpp>
#include <{@ namespace @}/{@ project_name @}.hpp>

TEST_CASE("Test case", "[greeting]") {
    REQUIRE({@ namespace @} ::get_version() == 1);
}